git clone https://github.com/tim-roethig/ai-platform.git
cd ai-platform/platform
docker compose up -d






#docker network create shared-network
docker compose up -d
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


vllm serve Qwen/Qwen3-235B-A22B-Instruct-2507-FP8 \
    --tensor-parallel-size 8 \
    --enable-expert-parallel \
    --gpu-memory-utilization 0.90 \
    --swap-space 0 \
    --max-model-len 32K

OLLAMA_KV_CACHE_TYPE=q8_0 \
OLLAMA_CONTEXT_LENGTH=32768 \
ollama run hf.co/unsloth/Qwen3-235B-A22B-Instruct-2507-GGUF:Q8_0


