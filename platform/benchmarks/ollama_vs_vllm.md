# Ollama vs vLLM comparison
vLLM and Ollama are both open‑source frameworks for running large‑language models, but they are designed for different goals. vLLM was developed by researchers at UC‑Berkeley’s Sky Computing Lab to squeeze maximum throughput from GPUs for production‑grade inference, while Ollama is a wrapper around the llama‑cpp library (now shifting to their own engine) that emphasizes simplicity and cross‑platform support.

## Why vLLM is Faster
### PagedAttention
The main bottleneck when serving LLMs is managing the key‑value (KV) cache used in attention layers. vLLM introduces a “PagedAttention” algorithm that treats the KV cache like a virtual memory system. Instead of allocating one large contiguous block for each sequence, it stores the cache in flexible “pages.” This avoids the severe memory fragmentation and wasted VRAM that afflict traditional approaches and allows vLLM to reuse memory across requests. By pre‑allocating GPU memory up to the maximum sequence length and managing it efficiently, vLLM can serve more concurrent sequences without running out of memory. Ollama, in contrast, uses llama‑cpp’s straightforward caching scheme it works well on consumer hardware but lacks these advanced memory optimizations.

### Continuous batching
Traditional inference servers build fixed batches of requests and wait for all responses before starting the next batch, under‑utilizing GPUs when some requests finish early. vLLM implements continuous batching—an “assembly‑line” approach that dynamically adds incoming requests to the batch as soon as there is room. This keeps GPUs busy and reduces queuing delay. Ollama generally handles requests one at a time or with limited batching, so GPU utilization drops quickly as concurrency increases. (Observed in tests)

## Benchmark
GPUs: 2x NVIDIA RTX L40S 48GB
Model: Qwen3-30B-A3B-Instruct-2507-FP8

### Benchmark Script
```python
%%time
import requests
import json
import sys
import threading
import signal
from time import perf_counter
import tiktoken

def num_tokens_from_string(string: str, encoding_name: str = "cl100k_base") -> int:
    """Returns the number of tokens in a text string."""
    encoding = tiktoken.get_encoding(encoding_name)
    num_tokens = len(encoding.encode(string))
    return num_tokens

port = 8000
model = "Qwen/Qwen3-4B-Instruct-2507-FP8"
url = f"http://0.0.0.0:{port}/v1/chat/completions"
headers = {"Content-Type": "application/json"}
prompt = """Artificial Intelligence: An Evolving Force
Artificial Intelligence (AI) refers to the development of computer systems that can perform tasks which traditionally required human intelligence. These tasks include recognizing patterns, understanding natural language, solving problems, making decisions, and even creating new content. While the term "AI" often evokes futuristic images of humanoid robots, the reality is that AI is already deeply embedded in daily life, shaping industries and transforming societies worldwide.
A Brief History
The concept of AI dates back centuries, with myths of artificial beings in ancient civilizations. However, the modern field began in the 1950s, when pioneers like Alan Turing, John McCarthy, and Marvin Minsky laid the theoretical and experimental groundwork. Turing’s famous question, “Can machines think?”, became a catalyst for decades of exploration. Early AI research focused on symbolic reasoning—teaching machines to follow logical rules. But as computers advanced, new approaches such as machine learning, neural networks, and deep learning emerged, enabling systems to learn from data rather than being explicitly programmed.
Types of AI
AI can be broadly categorized into three types:
Narrow AI (Weak AI):
The most common form today. Narrow AI systems are designed to handle specific tasks, such as speech recognition, image classification, or recommendation systems on streaming platforms. They outperform humans in their narrow domains but lack general intelligence.
General AI (Strong AI):
A theoretical form of AI that would have the ability to understand, learn, and apply intelligence across a wide range of tasks—similar to human cognition. General AI remains largely speculative and a topic of ongoing debate.
Superintelligent AI:
A hypothetical stage where AI surpasses human intelligence in all areas, potentially leading to groundbreaking discoveries—or existential risks. Scholars and technologists discuss this possibility with both excitement and caution.
How AI Works
At its core, AI relies on algorithms—sets of rules that allow computers to process data. Machine learning, a subset of AI, involves feeding systems vast amounts of data so they can recognize patterns and make predictions. Deep learning, inspired by the human brain, uses layered neural networks to process complex data such as images, speech, and text. The rise of powerful hardware and cloud computing has accelerated progress, making today’s AI systems more capable than ever.
Applications of AI
AI is no longer confined to research labs; it powers much of the technology we interact with daily:
Healthcare: AI helps doctors detect diseases, analyze medical images, and develop personalized treatment plans. It is also used in drug discovery and pandemic tracking.
Business and Finance: From fraud detection to customer support chatbots, AI automates processes and enhances decision-making.
Transportation: Self-driving cars, predictive traffic systems, and AI-driven logistics are transforming how people and goods move.
Education: Personalized learning platforms adapt to student needs, providing tailored lessons and feedback.
Entertainment: Recommendation engines on streaming services and AI-generated art or music highlight creativity’s intersection with technology.
Everyday Life: Virtual assistants like Siri, Alexa, and ChatGPT showcase AI’s ability to interact naturally with humans.
Benefits of AI
AI offers tremendous opportunities. It increases efficiency, reduces human error, and unlocks new innovations. By automating repetitive tasks, it allows people to focus on more creative and strategic work. In science, AI accelerates research, enabling breakthroughs in fields ranging from climate modeling to astrophysics. It also has the potential to democratize knowledge and services, making advanced tools accessible to more people.
Challenges and Concerns
Despite its promise, AI poses serious challenges:
Bias and Fairness: AI systems can inherit biases from their training data, leading to unfair outcomes in areas like hiring, policing, and lending.
Privacy: AI’s reliance on massive datasets raises concerns about surveillance and misuse of personal information.
Job Displacement: Automation threatens to replace some human jobs, requiring societies to rethink education, workforce training, and economic safety nets.
Ethical Use: From autonomous weapons to misinformation, AI can be weaponized in harmful ways.
Control and Alignment: Ensuring that increasingly powerful AI systems act in accordance with human values is a pressing research concern.
The Future of AI
The trajectory of AI is both promising and uncertain. Many experts envision a future where AI augments human capabilities, solving problems previously thought insurmountable. At the same time, policymakers, researchers, and citizens must grapple with ethical and societal implications. Global collaboration will be crucial to ensure AI’s benefits are widely shared and its risks managed responsibly.
Conclusion
Artificial Intelligence is not just a technological revolution—it is a societal transformation. From healthcare to art, AI reshapes how we live, work, and imagine the future. Whether it becomes humanity’s greatest tool or its most dangerous invention depends on the choices made today. The story of AI is still unfolding, and every individual, business, and government has a role to play in shaping its impact.
Would you like me to make this more academic and formal (like a research-style essay), or more engaging and narrative (like an article for a general audience)?

Rewrite this text in a longer form."""
num_runs = 16

print_lock = threading.Lock()
shutdown = threading.Event()

def stream_chat(thread_id: int, user_prompt: str):
    """
    Open a streaming completion and print tokens as they arrive.
    Each line is prefixed with [thread_id] to distinguish outputs.
    """

    start_ts = perf_counter()

    data = {
        "model": model,
        "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": user_prompt}
        ],
        "stream": True
    }

    try:
        llm_response = ""
        with requests.post(
            url,
            headers=headers,
            data=json.dumps(data),
            stream=True,
            timeout=(10, 600),
        ) as response:
            response.raise_for_status()

            for raw in response.iter_lines(decode_unicode=True):
                if shutdown.is_set():
                    break
                if not raw:
                    continue
                line = raw.strip()
                if line == "data: [DONE]":
                    break
                if line.startswith("data: "):
                    payload_str = line[len("data: "):]
                    try:
                        payload = json.loads(payload_str)
                        delta = payload["choices"][0]["delta"]
                        if "content" in delta:
                            with print_lock:
                                llm_response += delta['content']
                                #print(delta['content'], end="")
                    except Exception:
                        continue
    except requests.RequestException as e:
        with print_lock:
            print(f"\n[{thread_id:04d}] Request failed: {e}", file=sys.stderr)
    finally:
        elapsed = perf_counter() - start_ts
        tokens = num_tokens_from_string(llm_response, "cl100k_base")
        tokens_per_sec = tokens / elapsed
        with print_lock:
            print(f"\n[{thread_id:04d}] <stream complete> ({elapsed:4.3f} sec) ({tokens:04d} tokens) ({tokens_per_sec:4.3f} tokens/sec)")

def handle_sigint(signum, frame):
    shutdown.set()
    with print_lock:
        print("\n<Ctrl-C received; requesting threads to stop...>")

signal.signal(signal.SIGINT, handle_sigint)

threads = []
for i in range(1, num_runs + 1):
    t = threading.Thread(target=stream_chat, args=(i, prompt), daemon=True)
    t.start()
    threads.append(t)

for t in threads:
    t.join()

print("\nAll threads finished.")
```

### vLLM
```
(workspace) (main) root@C.26183956:/workspace$ vllm --version
INFO 09-24 19:55:02 [__init__.py:216] Automatically detected platform cuda.
0.10.2
```
```sh
vllm serve Qwen/Qwen3-30B-A3B-Instruct-2507-FP8 \
    --tensor-parallel-size 2 \
    --enable-expert-parallel \
    --gpu-memory-utilization 0.95 \
    --swap-space 0 \
    --max-model-len 32K
```

```
(Worker_TP1_EP1 pid=2295) INFO 09-24 19:58:12 [gpu_worker.py:298] Available KV cache memory: 25.91 GiB
(EngineCore_DP0 pid=2225) INFO 09-24 19:58:12 [kv_cache_utils.py:864] GPU KV cache size: 566,016 tokens
(EngineCore_DP0 pid=2225) INFO 09-24 19:58:12 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 17.27x

(main) root@C.26183956:/workspace$ nvidia-smi
Wed Sep 24 20:09:11 2025       
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 565.57.01              Driver Version: 565.57.01      CUDA Version: 12.7     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA L40S                    On  |   00000000:56:00.0 Off |                    0 |
| N/A   58C    P0            259W /  350W |   45241MiB /  46068MiB |     95%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
|   1  NVIDIA L40S                    On  |   00000000:57:00.0 Off |                    0 |
| N/A   61C    P0            271W /  350W |   45241MiB /  46068MiB |     93%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
                                                                                         
+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|    0   N/A  N/A      2294      C   VLLM::Worker_TP0_EP0                        45232MiB |
|    1   N/A  N/A      2295      C   VLLM::Worker_TP1_EP1                        45232MiB |
+-----------------------------------------------------------------------------------------+
```

#### Single Request
```
[0001] <stream complete> (14.278 sec) (1655 tokens) (115.915 tokens/sec)

All threads finished.
CPU times: user 91.5 ms, sys: 47 ms, total: 139 ms
Wall time: 14.3 s
```

#### 8 parallel requests
```
[0008] <stream complete> (18.403 sec) (1289 tokens) (70.042 tokens/sec)
[0002] <stream complete> (19.308 sec) (1344 tokens) (69.608 tokens/sec)
[0004] <stream complete> (19.335 sec) (1357 tokens) (70.184 tokens/sec)
[0001] <stream complete> (19.342 sec) (1358 tokens) (70.209 tokens/sec)
[0006] <stream complete> (21.966 sec) (1570 tokens) (71.475 tokens/sec)
[0007] <stream complete> (22.443 sec) (1603 tokens) (71.425 tokens/sec)
[0003] <stream complete> (24.622 sec) (1805 tokens) (73.309 tokens/sec)
[0005] <stream complete> (27.033 sec) (2087 tokens) (77.203 tokens/sec)

All threads finished.
CPU times: user 1.22 s, sys: 644 ms, total: 1.87 s
Wall time: 27 s
```

#### 32 parallel requests
```
[0003] <stream complete> (25.601 sec) (1209 tokens) (47.224 tokens/sec)
[0009] <stream complete> (26.346 sec) (1245 tokens) (47.256 tokens/sec)
[0012] <stream complete> (26.661 sec) (1258 tokens) (47.184 tokens/sec)
[0022] <stream complete> (27.046 sec) (1263 tokens) (46.698 tokens/sec)
[0004] <stream complete> (28.290 sec) (1321 tokens) (46.694 tokens/sec)
[0026] <stream complete> (28.529 sec) (1332 tokens) (46.689 tokens/sec)
[0028] <stream complete> (28.853 sec) (1348 tokens) (46.719 tokens/sec)
[0017] <stream complete> (29.242 sec) (1366 tokens) (46.714 tokens/sec)
[0014] <stream complete> (29.453 sec) (1372 tokens) (46.582 tokens/sec)
[0030] <stream complete> (29.461 sec) (1378 tokens) (46.774 tokens/sec)
[0020] <stream complete> (29.615 sec) (1379 tokens) (46.564 tokens/sec)
[0016] <stream complete> (29.690 sec) (1384 tokens) (46.614 tokens/sec)
[0001] <stream complete> (29.737 sec) (1381 tokens) (46.441 tokens/sec)
[0002] <stream complete> (29.935 sec) (1393 tokens) (46.534 tokens/sec)
[0010] <stream complete> (30.026 sec) (1402 tokens) (46.693 tokens/sec)
[0008] <stream complete> (30.163 sec) (1407 tokens) (46.647 tokens/sec)
[0007] <stream complete> (31.893 sec) (1500 tokens) (47.032 tokens/sec)
[0023] <stream complete> (33.129 sec) (1567 tokens) (47.300 tokens/sec)
[0005] <stream complete> (34.469 sec) (1632 tokens) (47.347 tokens/sec)
[0032] <stream complete> (36.266 sec) (1731 tokens) (47.731 tokens/sec)
[0013] <stream complete> (38.213 sec) (1831 tokens) (47.916 tokens/sec)
[0018] <stream complete> (38.412 sec) (1842 tokens) (47.954 tokens/sec)
[0025] <stream complete> (38.986 sec) (1867 tokens) (47.889 tokens/sec)
[0029] <stream complete> (39.169 sec) (1882 tokens) (48.048 tokens/sec)
[0019] <stream complete> (39.803 sec) (1927 tokens) (48.413 tokens/sec)
[0006] <stream complete> (40.051 sec) (1934 tokens) (48.288 tokens/sec)
[0011] <stream complete> (40.828 sec) (1990 tokens) (48.741 tokens/sec)
[0031] <stream complete> (40.919 sec) (1992 tokens) (48.682 tokens/sec)
[0027] <stream complete> (41.071 sec) (2012 tokens) (48.989 tokens/sec)
[0015] <stream complete> (41.376 sec) (2018 tokens) (48.773 tokens/sec)
[0024] <stream complete> (41.900 sec) (2080 tokens) (49.642 tokens/sec)
[0021] <stream complete> (42.237 sec) (2108 tokens) (49.909 tokens/sec)

All threads finished.
CPU times: user 4.98 s, sys: 2.55 s, total: 7.53 s
Wall time: 42.3 s
```

#### 256 parallel requests
All threads finished.
CPU times: user 37.1 s, sys: 20.8 s, total: 57.9 s
Wall time: 2min 7s

#### 1024 parallel requests
All threads finished.
CPU times: user 2min 33s, sys: 1min 21s, total: 3min 55s
Wall time: 9min 29s

### ollama v0.12.1
```
root@C.26181166:/$ ollama --version
ollama version is 0.12.1
```
```sh
OLLAMA_KV_CACHE_TYPE=q8_0 \
OLLAMA_CONTEXT_LENGTH=32768 \
OLLAMA_NUM_PARALLEL=9 \
OLLAMA_FLASH_ATTENTION=1 \
ollama serve

ollama run hf.co/unsloth/Qwen3-30B-A3B-Instruct-2507-GGUF:Q8_0
```

```
root@C.26181166:/$ ollama ps
NAME                                                   ID              SIZE     PROCESSOR    CONTEXT    UNTIL              
hf.co/unsloth/Qwen3-30B-A3B-Instruct-2507-GGUF:Q8_0    7f1ae4a3b3a9    88 GB    100% GPU     32768      4 minutes from now   

(main) root@C.26183956:/workspace$ nvidia-smi
Wed Sep 24 20:29:11 2025       
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 565.57.01              Driver Version: 565.57.01      CUDA Version: 12.7     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA L40S                    On  |   00000000:56:00.0 Off |                    0 |
| N/A   43C    P0            164W /  350W |   24461MiB /  46068MiB |     40%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
|   1  NVIDIA L40S                    On  |   00000000:57:00.0 Off |                    0 |
| N/A   46C    P0            159W /  350W |   22933MiB /  46068MiB |     38%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
                                                                                         
+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|    0   N/A  N/A      5696      C   /usr/local/bin/ollama                       24452MiB |
|    1   N/A  N/A      5696      C   /usr/local/bin/ollama                       22924MiB |
+-----------------------------------------------------------------------------------------+
```

#### Single Request
```
[0001] <stream complete> (19.597 sec) (2125 tokens) (108.437 tokens/sec)

All threads finished.
CPU times: user 303 ms, sys: 94.7 ms, total: 398 ms
Wall time: 19.6 s
```

#### 8 parallel requests
```
[0005] <stream complete> (68.692 sec) (1522 tokens) (22.157 tokens/sec)
[0007] <stream complete> (81.954 sec) (1810 tokens) (22.086 tokens/sec)
[0004] <stream complete> (85.320 sec) (1904 tokens) (22.316 tokens/sec)
[0008] <stream complete> (91.871 sec) (1959 tokens) (21.323 tokens/sec)
[0002] <stream complete> (102.868 sec) (2197 tokens) (21.357 tokens/sec)
[0006] <stream complete> (102.960 sec) (2203 tokens) (21.397 tokens/sec)
[0001] <stream complete> (109.984 sec) (2524 tokens) (22.949 tokens/sec)
[0003] <stream complete> (110.505 sec) (2586 tokens) (23.402 tokens/sec)

All threads finished.
CPU times: user 2.44 s, sys: 1.04 s, total: 3.48 s
Wall time: 1min 50s
```

#### 32 parallel requests
```
[0002] <stream complete> (81.716 sec) (1633 tokens) (19.984 tokens/sec)
[0011] <stream complete> (84.674 sec) (1690 tokens) (19.959 tokens/sec)
[0016] <stream complete> (91.895 sec) (1828 tokens) (19.892 tokens/sec)
[0013] <stream complete> (93.270 sec) (1857 tokens) (19.910 tokens/sec)
[0007] <stream complete> (105.184 sec) (2083 tokens) (19.803 tokens/sec)
[0008] <stream complete> (106.323 sec) (2149 tokens) (20.212 tokens/sec)
[0015] <stream complete> (107.503 sec) (2111 tokens) (19.637 tokens/sec)
[0003] <stream complete> (110.258 sec) (2196 tokens) (19.917 tokens/sec)
[0014] <stream complete> (127.503 sec) (2497 tokens) (19.584 tokens/sec)
[0004] <stream complete> (165.470 sec) (1593 tokens) (9.627 tokens/sec)
[0001] <stream complete> (172.169 sec) (1563 tokens) (9.078 tokens/sec)
[0009] <stream complete> (175.024 sec) (1865 tokens) (10.656 tokens/sec)
[0020] <stream complete> (175.569 sec) (1368 tokens) (7.792 tokens/sec)
[0018] <stream complete> (178.027 sec) (1736 tokens) (9.751 tokens/sec)
[0006] <stream complete> (189.133 sec) (1605 tokens) (8.486 tokens/sec)
[0005] <stream complete> (190.704 sec) (1714 tokens) (8.988 tokens/sec)
[0010] <stream complete> (213.822 sec) (1771 tokens) (8.283 tokens/sec)
[0019] <stream complete> (226.608 sec) (2355 tokens) (10.392 tokens/sec)
[0025] <stream complete> (257.856 sec) (1863 tokens) (7.225 tokens/sec)
[0017] <stream complete> (258.186 sec) (1643 tokens) (6.364 tokens/sec)
[0012] <stream complete> (258.904 sec) (1631 tokens) (6.300 tokens/sec)
[0022] <stream complete> (284.198 sec) (2166 tokens) (7.621 tokens/sec)
[0030] <stream complete> (295.904 sec) (1613 tokens) (5.451 tokens/sec)
[0023] <stream complete> (296.297 sec) (2114 tokens) (7.135 tokens/sec)
[0029] <stream complete> (315.348 sec) (2744 tokens) (8.701 tokens/sec)
[0027] <stream complete> (335.374 sec) (2726 tokens) (8.128 tokens/sec)
[0032] <stream complete> (335.635 sec) (1374 tokens) (4.094 tokens/sec)
[0024] <stream complete> (339.848 sec) (1456 tokens) (4.284 tokens/sec)
[0031] <stream complete> (347.381 sec) (2245 tokens) (6.463 tokens/sec)
[0021] <stream complete> (347.695 sec) (1636 tokens) (4.705 tokens/sec)
[0026] <stream complete> (367.208 sec) (2087 tokens) (5.683 tokens/sec)
[0028] <stream complete> (369.792 sec) (2065 tokens) (5.584 tokens/sec)

All threads finished.
CPU times: user 9.03 s, sys: 3.51 s, total: 12.5 s
Wall time: 6min 9s
```

#### 256 parallel requests
takes to long

#### 1024 parallel requests
takes to long


### ollama v0.12.2
```
root@C.26181166:/$ ollama --version
ollama version is 0.12.2
```
```sh
OLLAMA_KV_CACHE_TYPE=q8_0 \
OLLAMA_CONTEXT_LENGTH=32768 \
OLLAMA_NUM_PARALLEL=32 \
OLLAMA_FLASH_ATTENTION=1 \
ollama serve

ollama run hf.co/unsloth/Qwen3-30B-A3B-Instruct-2507-GGUF:Q8_0
```

(main) root@C.26186117:/workspace$ ollama ps
NAME                                                   ID              SIZE     PROCESSOR    CONTEXT    UNTIL              
hf.co/unsloth/Qwen3-30B-A3B-Instruct-2507-GGUF:Q8_0    7f1ae4a3b3a9    89 GB    100% GPU     32768      2 minutes from now  

Wed Sep 24 22:08:17 2025
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 565.57.01              Driver Version: 565.57.01      CUDA Version: 12.7     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA L40S                    On  |   00000000:56:00.0 Off |                    0 |
| N/A   44C    P0            157W /  350W |   43195MiB /  46068MiB |     26%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
|   1  NVIDIA L40S                    On  |   00000000:57:00.0 Off |                    0 |
| N/A   46C    P0            155W /  350W |   43503MiB /  46068MiB |     37%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+

+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|    0   N/A  N/A      2927      C   /usr/local/bin/ollama                       43186MiB |
|    1   N/A  N/A      2927      C   /usr/local/bin/ollama                       43494MiB |
+-----------------------------------------------------------------------------------------+

#### 32 parallel requests
```
[0005] <stream complete> (144.988 sec) (1344 tokens) (9.270 tokens/sec)
[0016] <stream complete> (157.020 sec) (1457 tokens) (9.279 tokens/sec)
[0020] <stream complete> (161.997 sec) (1508 tokens) (9.309 tokens/sec)
[0030] <stream complete> (163.138 sec) (1538 tokens) (9.428 tokens/sec)
[0029] <stream complete> (167.623 sec) (1563 tokens) (9.324 tokens/sec)
[0023] <stream complete> (171.784 sec) (1603 tokens) (9.331 tokens/sec)
[0028] <stream complete> (178.282 sec) (1685 tokens) (9.451 tokens/sec)
[0014] <stream complete> (184.993 sec) (1734 tokens) (9.373 tokens/sec)
[0027] <stream complete> (191.765 sec) (1805 tokens) (9.413 tokens/sec)
[0011] <stream complete> (198.051 sec) (1866 tokens) (9.422 tokens/sec)
[0004] <stream complete> (199.487 sec) (1849 tokens) (9.269 tokens/sec)
[0007] <stream complete> (207.035 sec) (1947 tokens) (9.404 tokens/sec)
[0031] <stream complete> (211.918 sec) (1971 tokens) (9.301 tokens/sec)
[0018] <stream complete> (214.186 sec) (1989 tokens) (9.286 tokens/sec)
[0021] <stream complete> (214.471 sec) (2017 tokens) (9.405 tokens/sec)
[0006] <stream complete> (217.073 sec) (2050 tokens) (9.444 tokens/sec)
[0015] <stream complete> (219.730 sec) (2046 tokens) (9.311 tokens/sec)
[0012] <stream complete> (220.369 sec) (2067 tokens) (9.380 tokens/sec)
[0019] <stream complete> (221.924 sec) (2109 tokens) (9.503 tokens/sec)
[0010] <stream complete> (223.944 sec) (2087 tokens) (9.319 tokens/sec)
[0017] <stream complete> (227.541 sec) (2163 tokens) (9.506 tokens/sec)
[0001] <stream complete> (232.086 sec) (2214 tokens) (9.540 tokens/sec)
[0013] <stream complete> (235.298 sec) (2249 tokens) (9.558 tokens/sec)
[0032] <stream complete> (239.177 sec) (2297 tokens) (9.604 tokens/sec)
[0026] <stream complete> (240.299 sec) (2314 tokens) (9.630 tokens/sec)
[0024] <stream complete> (242.882 sec) (2380 tokens) (9.799 tokens/sec)
[0003] <stream complete> (245.024 sec) (2439 tokens) (9.954 tokens/sec)
[0025] <stream complete> (246.570 sec) (2443 tokens) (9.908 tokens/sec)
[0008] <stream complete> (249.190 sec) (2470 tokens) (9.912 tokens/sec)
[0009] <stream complete> (251.454 sec) (2519 tokens) (10.018 tokens/sec)
[0002] <stream complete> (255.629 sec) (2592 tokens) (10.140 tokens/sec)
[0022] <stream complete> (256.320 sec) (2655 tokens) (10.358 tokens/sec)

All threads finished.
CPU times: user 10.6 s, sys: 4.36 s, total: 14.9 s
Wall time: 4min 16s
```