import requests

url = "http://0.0.0.0:8000/v1/models"

response = requests.get(url)

print("Status Code:", response.status_code)
print("Response Body:", response.json())


############################################################################


import requests
import json
import sys

url = "http://0.0.0.0:8000/v1/chat/completions"
headers = {"Content-Type": "application/json"}

data = {
    "model": "RedHatAI/Qwen2.5-VL-72B-Instruct-FP8-dynamic",
    "messages": [
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": "Write a long text about AI."}
    ],
    "stream": True
}

with requests.post(url, headers=headers, data=json.dumps(data), stream=True) as response:
    for line in response.iter_lines():
        if line:
            decoded = line.decode("utf-8")
            if decoded.startswith("data: "):
                try:
                    payload = json.loads(decoded[len("data: "):])
                    delta = payload["choices"][0]["delta"]
                    if "content" in delta:
                        sys.stdout.write(delta["content"])
                        sys.stdout.flush()
                except:
                    pass


############################################################################
%%time
import requests
import json
import sys
import threading
import signal

url = "http://0.0.0.0:8000/v1/chat/completions"
headers = {"Content-Type": "application/json"}

# The single prompt you want to run repeatedly
prompt = "Write a long text about AI."

# How many times to execute it in parallel
num_runs = 1024

print_lock = threading.Lock()
shutdown = threading.Event()

def stream_chat(thread_id: int, user_prompt: str):
    """
    Open a streaming completion and print tokens as they arrive.
    Each line is prefixed with [thread_id] to distinguish outputs.
    """
    data = {
        "model": "Qwen/Qwen3-30B-A3B-Instruct-2507-FP8",
        "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": user_prompt}
        ],
        "stream": True
    }

    try:
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
                                #sys.stdout.write(f"[{thread_id}] {delta['content']}")
                                #sys.stdout.flush()
                                pass
                    except Exception:
                        continue
    except requests.RequestException as e:
        with print_lock:
            print(f"\n[{thread_id}] Request failed: {e}", file=sys.stderr)
    finally:
        with print_lock:
            # print(f"\n[{thread_id}] <stream complete>")
            pass

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