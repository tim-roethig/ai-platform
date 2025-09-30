## serve
```sh
uv venv vllm-env --python 3.12 --seed
source vllm-env/bin/activate
pip install -U pip
pip install git+https://github.com/huggingface/transformers
pip install accelerate qwen-vl-utils==0.0.14 flashinfer-python nvidia-ml-py
pip uninstall pynvml
uv pip install -U vllm \
    --torch-backend=auto \
    --extra-index-url https://wheels.vllm.ai/nightly
vllm serve QuantTrio/Qwen3-VL-235B-A22B-Instruct-FP8 \
    --tensor-parallel-size 8 \
    --enable-expert-parallel \
    --gpu-memory-utilization 0.9 \
    --swap-space 0 \
    --limit-mm-per-prompt '{"video": 0}' \
    --max-model-len 32K
```

## benchmark
```sh
uv venv lm-eval-env --python 3.12 --seed
source lm-eval-env/bin/activate
git clone --depth 1 https://github.com/EleutherAI/lm-evaluation-harness
cd lm-evaluation-harness
pip install -e .
pip install -e ".[api]"
pip install -e ".[ibm_watsonx_ai]"
pip install langdetect immutabledict Pillow
HF_ALLOW_CODE_EVAL="1" lm_eval \
    --model local-completions \
    --tasks humaneval,fda,chartqa,arc_challenge,gsm8k \
    --confirm_run_unsafe_code \
    --model_args model=QuantTrio/Qwen3-VL-235B-A22B-Instruct-FP8,base_url=http://0.0.0.0:8000/v1/completions,num_concurrent=512,max_retries=1,tokenized_requests=False,timeout=6000
```

## fp8
### kv cache
```
(Worker_TP5_EP5 pid=55774) INFO 09-29 16:08:47 [gpu_worker.py:298] Available KV cache memory: 9.71 GiB
(Worker_TP6_EP6 pid=55775) INFO 09-29 16:08:47 [gpu_worker.py:298] Available KV cache memory: 9.71 GiB
(Worker_TP0_EP0 pid=55769) INFO 09-29 16:08:47 [gpu_worker.py:298] Available KV cache memory: 9.73 GiB
(Worker_TP2_EP2 pid=55771) INFO 09-29 16:08:47 [gpu_worker.py:298] Available KV cache memory: 9.71 GiB
(Worker_TP1_EP1 pid=55770) INFO 09-29 16:08:48 [gpu_worker.py:298] Available KV cache memory: 9.71 GiB
(Worker_TP7_EP7 pid=55776) INFO 09-29 16:08:48 [gpu_worker.py:298] Available KV cache memory: 9.72 GiB
(Worker_TP4_EP4 pid=55773) INFO 09-29 16:08:48 [gpu_worker.py:298] Available KV cache memory: 9.73 GiB
(Worker_TP3_EP3 pid=55772) INFO 09-29 16:08:48 [gpu_worker.py:298] Available KV cache memory: 9.72 GiB
(EngineCore_DP0 pid=55627) INFO 09-29 16:08:48 [kv_cache_utils.py:1087] GPU KV cache size: 217,104 tokens
(EngineCore_DP0 pid=55627) INFO 09-29 16:08:48 [kv_cache_utils.py:1091] Maximum concurrency for 32,768 tokens per request: 6.63x
(EngineCore_DP0 pid=55627) INFO 09-29 16:08:48 [kv_cache_utils.py:1087] GPU KV cache size: 216,656 tokens
(EngineCore_DP0 pid=55627) INFO 09-29 16:08:48 [kv_cache_utils.py:1091] Maximum concurrency for 32,768 tokens per request: 6.61x
(EngineCore_DP0 pid=55627) INFO 09-29 16:08:48 [kv_cache_utils.py:1087] GPU KV cache size: 216,656 tokens
(EngineCore_DP0 pid=55627) INFO 09-29 16:08:48 [kv_cache_utils.py:1091] Maximum concurrency for 32,768 tokens per request: 6.61x
(EngineCore_DP0 pid=55627) INFO 09-29 16:08:48 [kv_cache_utils.py:1087] GPU KV cache size: 216,752 tokens
(EngineCore_DP0 pid=55627) INFO 09-29 16:08:48 [kv_cache_utils.py:1091] Maximum concurrency for 32,768 tokens per request: 6.61x
(EngineCore_DP0 pid=55627) INFO 09-29 16:08:48 [kv_cache_utils.py:1087] GPU KV cache size: 217,104 tokens
(EngineCore_DP0 pid=55627) INFO 09-29 16:08:48 [kv_cache_utils.py:1091] Maximum concurrency for 32,768 tokens per request: 6.63x
(EngineCore_DP0 pid=55627) INFO 09-29 16:08:48 [kv_cache_utils.py:1087] GPU KV cache size: 216,656 tokens
(EngineCore_DP0 pid=55627) INFO 09-29 16:08:48 [kv_cache_utils.py:1091] Maximum concurrency for 32,768 tokens per request: 6.61x
(EngineCore_DP0 pid=55627) INFO 09-29 16:08:48 [kv_cache_utils.py:1087] GPU KV cache size: 216,656 tokens
(EngineCore_DP0 pid=55627) INFO 09-29 16:08:48 [kv_cache_utils.py:1091] Maximum concurrency for 32,768 tokens per request: 6.61x
(EngineCore_DP0 pid=55627) INFO 09-29 16:08:48 [kv_cache_utils.py:1087] GPU KV cache size: 216,752 tokens
(EngineCore_DP0 pid=55627) INFO 09-29 16:08:48 [kv_cache_utils.py:1091] Maximum concurrency for 32,768 tokens per request: 6.61x
```
### speed
```
2025-09-29:16:12:14 INFO     [api.task:434] Building contexts for humaneval on rank 0...
100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 164/164 [00:00<00:00, 2552.78it/s]
2025-09-29:16:12:14 INFO     [api.task:434] Building contexts for gsm8k on rank 0...
100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 1319/1319 [00:04<00:00, 269.42it/s]
2025-09-29:16:12:19 INFO     [api.task:434] Building contexts for fda on rank 0...
100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████| 1102/1102 [00:00<00:00, 295173.57it/s]
2025-09-29:16:12:19 INFO     [api.task:434] Building contexts for chartqa on rank 0...
100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 2500/2500 [00:01<00:00, 2093.77it/s]
2025-09-29:16:12:37 INFO     [api.task:434] Building contexts for arc_challenge on rank 0...
100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 1172/1172 [00:00<00:00, 1529.83it/s]
2025-09-29:16:12:38 INFO     [evaluator:574] Running generate_until requests
2025-09-29:16:12:38 INFO     [models.api_models:692] Tokenized requests are disabled. Context + generation length is not checked.
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 164/164 [01:10<00:00,  2.33it/s]
Requesting API: 100%|██████████████████████████████████████████████████████████████████████████████████████████████████| 1319/1319 [18:36<00:00,  1.18it/s]
Requesting API: 100%|██████████████████████████████████████████████████████████████████████████████████████████████████| 1102/1102 [13:23<00:00,  1.37it/s]
Requesting API: 100%|██████████████████████████████████████████████████████████████████████████████████████████████████| 2500/2500 [13:26<00:00,  3.10it/s]
2025-09-29:16:59:15 INFO     [evaluator:574] Running loglikelihood requests
Requesting API: 100%|██████████████████████████████████████████████████████████████████████████████████████████████████| 4687/4687 [02:09<00:00, 36.30it/s]
```
### quality
```
2025-09-29:17:03:09 INFO     [loggers.evaluation_tracker:280] Output path not provided, skipping saving results aggregated
local-completions (model=QuantTrio/Qwen3-VL-235B-A22B-Instruct-FP8,base_url=http://0.0.0.0:8000/v1/completions,num_concurrent=512,max_retries=1,tokenized_requests=False,timeout=6000), gen_kwargs: (None), limit: None, num_fewshot: None, batch_size: 1
|    Tasks    |Version|     Filter     |n-shot|     Metric      |   |Value |   |Stderr|
|-------------|------:|----------------|-----:|-----------------|---|-----:|---|------|
|arc_challenge|      1|none            |     0|acc              |↑  |0.5922|±  |0.0144|
|             |       |none            |     0|acc_norm         |↑  |0.6118|±  |0.0142|
|chartqa      |      0|none            |     0|anywhere_accuracy|↑  |0.1176|±  |0.0064|
|             |       |none            |     0|exact_match      |↑  |0.0468|±  |0.0042|
|             |       |none            |     0|relaxed_accuracy |↑  |0.1132|±  |0.0063|
|fda          |      0|none            |     0|contains         |↑  |0.7486|±  |   N/A|
|gsm8k        |      3|flexible-extract|     5|exact_match      |↑  |0.9090|±  |0.0079|
|             |       |strict-match    |     5|exact_match      |↑  |0.8969|±  |0.0084|
|humaneval    |      1|create_test     |     0|pass@1           |   |0.5610|±  |0.0389|
```

## awq
### kv cache
```
(Worker_TP5_EP5 pid=48540) INFO 09-29 15:15:28 [gpu_worker.py:298] Available KV cache memory: 22.78 GiB
(Worker_TP2_EP2 pid=48537) INFO 09-29 15:15:28 [gpu_worker.py:298] Available KV cache memory: 22.78 GiB
(Worker_TP6_EP6 pid=48541) INFO 09-29 15:15:28 [gpu_worker.py:298] Available KV cache memory: 22.78 GiB
(Worker_TP3_EP3 pid=48538) INFO 09-29 15:15:28 [gpu_worker.py:298] Available KV cache memory: 22.78 GiB
(Worker_TP0_EP0 pid=48535) INFO 09-29 15:15:28 [gpu_worker.py:298] Available KV cache memory: 22.80 GiB
(Worker_TP1_EP1 pid=48536) INFO 09-29 15:15:28 [gpu_worker.py:298] Available KV cache memory: 22.78 GiB
(Worker_TP4_EP4 pid=48539) INFO 09-29 15:15:28 [gpu_worker.py:298] Available KV cache memory: 22.80 GiB
(Worker_TP7_EP7 pid=48542) INFO 09-29 15:15:29 [gpu_worker.py:298] Available KV cache memory: 22.78 GiB
(EngineCore_DP0 pid=48396) INFO 09-29 15:15:29 [kv_cache_utils.py:1087] GPU KV cache size: 508,624 tokens
(EngineCore_DP0 pid=48396) INFO 09-29 15:15:29 [kv_cache_utils.py:1091] Maximum concurrency for 32,768 tokens per request: 15.52x
(EngineCore_DP0 pid=48396) INFO 09-29 15:15:29 [kv_cache_utils.py:1087] GPU KV cache size: 508,192 tokens
(EngineCore_DP0 pid=48396) INFO 09-29 15:15:29 [kv_cache_utils.py:1091] Maximum concurrency for 32,768 tokens per request: 15.51x
(EngineCore_DP0 pid=48396) INFO 09-29 15:15:29 [kv_cache_utils.py:1087] GPU KV cache size: 508,192 tokens
(EngineCore_DP0 pid=48396) INFO 09-29 15:15:29 [kv_cache_utils.py:1091] Maximum concurrency for 32,768 tokens per request: 15.51x
(EngineCore_DP0 pid=48396) INFO 09-29 15:15:29 [kv_cache_utils.py:1087] GPU KV cache size: 508,272 tokens
(EngineCore_DP0 pid=48396) INFO 09-29 15:15:29 [kv_cache_utils.py:1091] Maximum concurrency for 32,768 tokens per request: 15.51x
(EngineCore_DP0 pid=48396) INFO 09-29 15:15:29 [kv_cache_utils.py:1087] GPU KV cache size: 508,624 tokens
(EngineCore_DP0 pid=48396) INFO 09-29 15:15:29 [kv_cache_utils.py:1091] Maximum concurrency for 32,768 tokens per request: 15.52x
(EngineCore_DP0 pid=48396) INFO 09-29 15:15:29 [kv_cache_utils.py:1087] GPU KV cache size: 508,192 tokens
(EngineCore_DP0 pid=48396) INFO 09-29 15:15:29 [kv_cache_utils.py:1091] Maximum concurrency for 32,768 tokens per request: 15.51x
(EngineCore_DP0 pid=48396) INFO 09-29 15:15:29 [kv_cache_utils.py:1087] GPU KV cache size: 508,144 tokens
(EngineCore_DP0 pid=48396) INFO 09-29 15:15:29 [kv_cache_utils.py:1091] Maximum concurrency for 32,768 tokens per request: 15.51x
(EngineCore_DP0 pid=48396) INFO 09-29 15:15:29 [kv_cache_utils.py:1087] GPU KV cache size: 508,272 tokens
(EngineCore_DP0 pid=48396) INFO 09-29 15:15:29 [kv_cache_utils.py:1091] Maximum concurrency for 32,768 tokens per request: 15.51x
```
### speed
```
2025-09-29:15:19:19 INFO     [api.task:434] Building contexts for humaneval on rank 0...
100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 164/164 [00:00<00:00, 2416.15it/s]
2025-09-29:15:19:19 INFO     [api.task:434] Building contexts for gsm8k on rank 0...
100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 1319/1319 [00:04<00:00, 283.55it/s]
2025-09-29:15:19:24 INFO     [api.task:434] Building contexts for fda on rank 0...
100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████| 1102/1102 [00:00<00:00, 290516.85it/s]
2025-09-29:15:19:24 INFO     [api.task:434] Building contexts for chartqa on rank 0...
100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 2500/2500 [00:01<00:00, 2040.03it/s]
2025-09-29:15:19:43 INFO     [api.task:434] Building contexts for arc_challenge on rank 0...
100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 1172/1172 [00:00<00:00, 1470.11it/s]
2025-09-29:15:19:43 INFO     [evaluator:574] Running generate_until requests
2025-09-29:15:19:43 INFO     [models.api_models:692] Tokenized requests are disabled. Context + generation length is not checked.
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 164/164 [01:03<00:00,  2.57it/s]
Requesting API: 100%|██████████████████████████████████████████████████████████████████████████████████████████████████| 1319/1319 [18:04<00:00,  1.22it/s]
Requesting API: 100%|██████████████████████████████████████████████████████████████████████████████████████████████████| 1102/1102 [13:09<00:00,  1.40it/s]
Requesting API: 100%|██████████████████████████████████████████████████████████████████████████████████████████████████| 2500/2500 [09:47<00:00,  4.26it/s]
2025-09-29:16:01:49 INFO     [evaluator:574] Running loglikelihood requests
Requesting API: 100%|██████████████████████████████████████████████████████████████████████████████████████████████████| 4687/4687 [02:07<00:00, 36.62it/s]
```
### quality
```
2025-09-29:16:05:41 INFO     [loggers.evaluation_tracker:280] Output path not provided, skipping saving results aggregated
local-completions (model=QuantTrio/Qwen3-VL-235B-A22B-Instruct-AWQ,base_url=http://0.0.0.0:8000/v1/completions,num_concurrent=512,max_retries=1,tokenized_requests=False,timeout=6000), gen_kwargs: (None), limit: None, num_fewshot: None, batch_size: 1
|    Tasks    |Version|     Filter     |n-shot|     Metric      |   |Value |   |Stderr|
|-------------|------:|----------------|-----:|-----------------|---|-----:|---|------|
|arc_challenge|      1|none            |     0|acc              |↑  |0.5964|±  |0.0143|
|             |       |none            |     0|acc_norm         |↑  |0.6391|±  |0.0140|
|chartqa      |      0|none            |     0|anywhere_accuracy|↑  |0.0728|±  |0.0052|
|             |       |none            |     0|exact_match      |↑  |0.0272|±  |0.0033|
|             |       |none            |     0|relaxed_accuracy |↑  |0.0716|±  |0.0052|
|fda          |      0|none            |     0|contains         |↑  |0.7223|±  |   N/A|
|gsm8k        |      3|flexible-extract|     5|exact_match      |↑  |0.9067|±  |0.0080|
|             |       |strict-match    |     5|exact_match      |↑  |0.8923|±  |0.0085|
|humaneval    |      1|create_test     |     0|pass@1           |   |0.4451|±  |0.0389|
```
