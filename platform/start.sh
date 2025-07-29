#docker network create shared-network
docker compose -f ./docker-compose.yaml up -d
#docker compose -f ./LibreChat/deploy-compose.yml up -d
#curl http://localhost:8000/v1/models
#curl http://localhost:8000/v1/chat/completions -H "Content-Type: application/json" -N -d '{"model": "/Qwen3-0.6B","messages": [{"role": "system", "content": "You are a helpful assistant."},{"role": "user", "content": "Write a long text."}],"stream": true}'
#curl http://localhost:8000/v1/embeddings -H "Content-Type: application/json" -N -d '{"model": "/Qwen3-Embedding-0.6B","input": ["Hi. I am Tim."]}'
#curl 'http://localhost:8001/rerank' -H 'Content-Type: application/json' -d '{"model": "/Qwen3-Embedding-0.6B","query": "What is the capital of France?","documents": ["Paris is the capital of France.","Switzerland is a rich country.","Berlin is the capital of Germany.","Marseille is a town in France."]}'
#curl 'http://localhost:8000/rerank' -H 'Content-Type: application/json' -d '{"model": "/Qwen3-0.6B","query": "What is the capital of France?","documents": ["Paris is the capital of France.","Switzerland is a rich country.","Berlin is the capital of Germany.","Marseille is a town in France."]}'
