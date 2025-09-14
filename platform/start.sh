#docker network create shared-network
docker compose -f ./docker-compose.yaml up -d
#docker compose -f ./LibreChat/deploy-compose.yml up -d
#curl http://localhost:8000/v1/models
#curl http://localhost:8000/v1/chat/completions -H "Content-Type: application/json" -N -d '{"model": "/Qwen3-0.6B","messages": [{"role": "system", "content": "You are a helpful assistant."},{"role": "user", "content": "Write a long text."}],"stream": true}'
#curl http://localhost:8000/v1/embeddings -H "Content-Type: application/json" -N -d '{"model": "/Qwen3-Embedding-0.6B","input": ["Hi. I am Tim."]}'
#curl 'http://localhost:8001/rerank' -H 'Content-Type: application/json' -d '{"model": "/Qwen3-Embedding-0.6B","query": "What is the capital of France?","documents": ["Paris is the capital of France.","Switzerland is a rich country.","Berlin is the capital of Germany.","Marseille is a town in France."]}'
#curl 'http://localhost:8000/rerank' -H 'Content-Type: application/json' -d '{"model": "/Qwen3-0.6B","query": "What is the capital of France?","documents": ["Paris is the capital of France.","Switzerland is a rich country.","Berlin is the capital of Germany.","Marseille is a town in France."]}'


pip install "transformers<4.53.0"

vllm serve RedHatAI/Qwen2.5-VL-72B-Instruct-FP8-dynamic \
    --tensor-parallel-size 8 \
    --gpu-memory-utilization 0.95 \
    --limit-mm-per-prompt '{"image":2,"video":0}' \
    --max-model-len 2K


# 8 L40s
# RedHatAI/Qwen2.5-VL-72B-Instruct-FP8-dynamic
# 33 tokens/sec
# GPU KV cache size: 803,600 tokens
# Maximum concurrency for 32,768 tokens per request: 24.52x

import requests

url = "http://0.0.0.0:8000/v1/models"

response = requests.get(url)

print("Status Code:", response.status_code)
print("Response Body:", response.json())

%%time
import requests
import json

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
