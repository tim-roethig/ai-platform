## fp8
### kv cache
```
(Worker_TP0_EP0 pid=8092) INFO 09-29 11:34:04 [gpu_worker.py:298] Available KV cache memory: 11.55 GiB
(Worker_TP7_EP7 pid=8099) INFO 09-29 11:34:04 [gpu_worker.py:298] Available KV cache memory: 11.52 GiB
(Worker_TP1_EP1 pid=8093) INFO 09-29 11:34:04 [gpu_worker.py:298] Available KV cache memory: 11.51 GiB
(Worker_TP5_EP5 pid=8097) INFO 09-29 11:34:04 [gpu_worker.py:298] Available KV cache memory: 11.51 GiB
(Worker_TP4_EP4 pid=8096) INFO 09-29 11:34:05 [gpu_worker.py:298] Available KV cache memory: 11.55 GiB
(Worker_TP6_EP6 pid=8098) INFO 09-29 11:34:05 [gpu_worker.py:298] Available KV cache memory: 11.51 GiB
(Worker_TP3_EP3 pid=8095) INFO 09-29 11:34:05 [gpu_worker.py:298] Available KV cache memory: 11.52 GiB
(Worker_TP2_EP2 pid=8094) INFO 09-29 11:34:05 [gpu_worker.py:298] Available KV cache memory: 11.51 GiB
(EngineCore_DP0 pid=7949) INFO 09-29 11:34:06 [kv_cache_utils.py:864] GPU KV cache size: 257,664 tokens
(EngineCore_DP0 pid=7949) INFO 09-29 11:34:06 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 7.86x
(EngineCore_DP0 pid=7949) INFO 09-29 11:34:06 [kv_cache_utils.py:864] GPU KV cache size: 256,800 tokens
(EngineCore_DP0 pid=7949) INFO 09-29 11:34:06 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 7.84x
(EngineCore_DP0 pid=7949) INFO 09-29 11:34:06 [kv_cache_utils.py:864] GPU KV cache size: 256,800 tokens
(EngineCore_DP0 pid=7949) INFO 09-29 11:34:06 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 7.84x
(EngineCore_DP0 pid=7949) INFO 09-29 11:34:06 [kv_cache_utils.py:864] GPU KV cache size: 256,976 tokens
(EngineCore_DP0 pid=7949) INFO 09-29 11:34:06 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 7.84x
(EngineCore_DP0 pid=7949) INFO 09-29 11:34:06 [kv_cache_utils.py:864] GPU KV cache size: 257,664 tokens
(EngineCore_DP0 pid=7949) INFO 09-29 11:34:06 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 7.86x
(EngineCore_DP0 pid=7949) INFO 09-29 11:34:06 [kv_cache_utils.py:864] GPU KV cache size: 256,800 tokens
(EngineCore_DP0 pid=7949) INFO 09-29 11:34:06 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 7.84x
(EngineCore_DP0 pid=7949) INFO 09-29 11:34:06 [kv_cache_utils.py:864] GPU KV cache size: 256,800 tokens
(EngineCore_DP0 pid=7949) INFO 09-29 11:34:06 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 7.84x
(EngineCore_DP0 pid=7949) INFO 09-29 11:34:06 [kv_cache_utils.py:864] GPU KV cache size: 256,976 tokens
(EngineCore_DP0 pid=7949) INFO 09-29 11:34:06 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 7.84x
```

### quality and speed
```
2025-09-29:11:38:03 INFO     [api.task:434] Building contexts for mmlu_pro_economics on rank 0...
100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [00:00<00:00, 744.84it/s]
2025-09-29:11:38:03 INFO     [api.task:434] Building contexts for ifeval on rank 0...
100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [00:00<00:00, 104806.42it/s]
2025-09-29:11:38:03 INFO     [api.task:434] Building contexts for humaneval on rank 0...
100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 164/164 [00:00<00:00, 2721.20it/s]
2025-09-29:11:38:03 INFO     [api.task:434] Building contexts for fda on rank 0...
100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [00:00<00:00, 248551.35it/s]
2025-09-29:11:38:03 INFO     [evaluator:574] Running generate_until requests
2025-09-29:11:38:03 INFO     [models.api_models:692] Tokenized requests are disabled. Context + generation length is not checked.
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [04:09<00:00,  1.03it/s]
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [03:51<00:00,  1.11it/s]
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 164/164 [01:30<00:00,  1.80it/s]
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [03:13<00:00,  1.32it/s]
2025-09-29:11:51:17 INFO     [loggers.evaluation_tracker:280] Output path not provided, skipping saving results aggregated
local-completions (model=Qwen/Qwen3-235B-A22B-Instruct-2507-FP8,base_url=http://0.0.0.0:8000/v1/completions,num_concurrent=1024,max_retries=1,tokenized_requests=False), gen_kwargs: (None), limit: 256.0, num_fewshot: None, batch_size: 1
|  Tasks  |Version|    Filter    |n-shot|        Metric         |   |Value |   |Stderr|
|---------|------:|--------------|-----:|-----------------------|---|-----:|---|------|
|fda      |    0.0|none          |     0|contains               |↑  |0.7930|±  |   N/A|
|humaneval|    1.0|create_test   |     0|pass@1                 |   |0.3841|±  |0.0381|
|ifeval   |    4.0|none          |     0|inst_level_loose_acc   |↑  |0.7665|±  |   N/A|
|         |       |none          |     0|inst_level_strict_acc  |↑  |0.6802|±  |   N/A|
|         |       |none          |     0|prompt_level_loose_acc |↑  |0.6758|±  |0.0293|
|         |       |none          |     0|prompt_level_strict_acc|↑  |0.5508|±  |0.0311|
|economics|    2.1|custom-extract|     5|exact_match            |↑  |0.2070|±  |0.0254|
```
## awq
### kv cache
```
(Worker_TP5_EP5 pid=14498) INFO 09-29 11:58:48 [gpu_worker.py:298] Available KV cache memory: 24.58 GiB
(Worker_TP6_EP6 pid=14499) INFO 09-29 11:58:48 [gpu_worker.py:298] Available KV cache memory: 24.58 GiB
(Worker_TP0_EP0 pid=14493) INFO 09-29 11:58:48 [gpu_worker.py:298] Available KV cache memory: 24.62 GiB
(Worker_TP7_EP7 pid=14500) INFO 09-29 11:58:48 [gpu_worker.py:298] Available KV cache memory: 24.59 GiB
(Worker_TP1_EP1 pid=14494) INFO 09-29 11:58:49 [gpu_worker.py:298] Available KV cache memory: 24.58 GiB
(Worker_TP4_EP4 pid=14497) INFO 09-29 11:58:49 [gpu_worker.py:298] Available KV cache memory: 24.62 GiB
(Worker_TP2_EP2 pid=14495) INFO 09-29 11:58:49 [gpu_worker.py:298] Available KV cache memory: 24.58 GiB
(Worker_TP3_EP3 pid=14496) INFO 09-29 11:58:49 [gpu_worker.py:298] Available KV cache memory: 24.59 GiB
(EngineCore_DP0 pid=14353) INFO 09-29 11:58:49 [kv_cache_utils.py:864] GPU KV cache size: 549,232 tokens
(EngineCore_DP0 pid=14353) INFO 09-29 11:58:49 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 16.76x
(EngineCore_DP0 pid=14353) INFO 09-29 11:58:49 [kv_cache_utils.py:864] GPU KV cache size: 548,352 tokens
(EngineCore_DP0 pid=14353) INFO 09-29 11:58:49 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 16.73x
(EngineCore_DP0 pid=14353) INFO 09-29 11:58:49 [kv_cache_utils.py:864] GPU KV cache size: 548,352 tokens
(EngineCore_DP0 pid=14353) INFO 09-29 11:58:49 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 16.73x
(EngineCore_DP0 pid=14353) INFO 09-29 11:58:49 [kv_cache_utils.py:864] GPU KV cache size: 548,528 tokens
(EngineCore_DP0 pid=14353) INFO 09-29 11:58:49 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 16.74x
(EngineCore_DP0 pid=14353) INFO 09-29 11:58:49 [kv_cache_utils.py:864] GPU KV cache size: 549,232 tokens
(EngineCore_DP0 pid=14353) INFO 09-29 11:58:49 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 16.76x
(EngineCore_DP0 pid=14353) INFO 09-29 11:58:49 [kv_cache_utils.py:864] GPU KV cache size: 548,352 tokens
(EngineCore_DP0 pid=14353) INFO 09-29 11:58:49 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 16.73x
(EngineCore_DP0 pid=14353) INFO 09-29 11:58:49 [kv_cache_utils.py:864] GPU KV cache size: 548,352 tokens
(EngineCore_DP0 pid=14353) INFO 09-29 11:58:49 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 16.73x
(EngineCore_DP0 pid=14353) INFO 09-29 11:58:49 [kv_cache_utils.py:864] GPU KV cache size: 548,528 tokens
(EngineCore_DP0 pid=14353) INFO 09-29 11:58:49 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 16.74x
```

### quality and speed
```
2025-09-29:12:02:45 INFO     [api.task:434] Building contexts for mmlu_pro_economics on rank 0...
100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [00:00<00:00, 740.69it/s]
2025-09-29:12:02:45 INFO     [api.task:434] Building contexts for ifeval on rank 0...
100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [00:00<00:00, 103184.88it/s]
2025-09-29:12:02:45 INFO     [api.task:434] Building contexts for humaneval on rank 0...
100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 164/164 [00:00<00:00, 2781.78it/s]
2025-09-29:12:02:46 INFO     [api.task:434] Building contexts for fda on rank 0...
100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [00:00<00:00, 240695.32it/s]
2025-09-29:12:02:46 INFO     [evaluator:574] Running generate_until requests
2025-09-29:12:02:46 INFO     [models.api_models:692] Tokenized requests are disabled. Context + generation length is not checked.
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [03:10<00:00,  1.34it/s]
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [03:32<00:00,  1.20it/s]
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 164/164 [00:50<00:00,  3.26it/s]
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [03:04<00:00,  1.39it/s]
2025-09-29:12:13:52 INFO     [loggers.evaluation_tracker:280] Output path not provided, skipping saving results aggregated
local-completions (model=QuantTrio/Qwen3-235B-A22B-Instruct-2507-AWQ,base_url=http://0.0.0.0:8000/v1/completions,num_concurrent=1024,max_retries=1,tokenized_requests=False), gen_kwargs: (None), limit: 256.0, num_fewshot: None, batch_size: 1
|  Tasks  |Version|    Filter    |n-shot|        Metric         |   |Value |   |Stderr|
|---------|------:|--------------|-----:|-----------------------|---|-----:|---|------|
|fda      |    0.0|none          |     0|contains               |↑  |0.7969|±  |   N/A|
|humaneval|    1.0|create_test   |     0|pass@1                 |   |0.3902|±  |0.0382|
|ifeval   |    4.0|none          |     0|inst_level_loose_acc   |↑  |0.7589|±  |   N/A|
|         |       |none          |     0|inst_level_strict_acc  |↑  |0.6802|±  |   N/A|
|         |       |none          |     0|prompt_level_loose_acc |↑  |0.6719|±  |0.0294|
|         |       |none          |     0|prompt_level_strict_acc|↑  |0.5547|±  |0.0311|
|economics|    2.1|custom-extract|     5|exact_match            |↑  |0.2188|±  |0.0259|
```