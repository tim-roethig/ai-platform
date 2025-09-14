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
