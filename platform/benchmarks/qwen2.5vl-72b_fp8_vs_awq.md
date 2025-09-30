## RedHatAI/Qwen2.5-VL-72B-Instruct-FP8-dynamic
### vllm serve
```sh
uv venv lm-eval-env --python 3.12 --seed
source lm-eval-env/bin/activate
git clone --depth 1 https://github.com/EleutherAI/lm-evaluation-harness
cd lm-evaluation-harness
pip install -e .
pip install -e ".[api]"
pip install langdetect immutabledict Pillow
HF_ALLOW_CODE_EVAL="1" lm_eval \
    --model local-completions \
    --tasks mmlu_pro_economics,ifeval,humaneval,fda,chartqa \
    --limit 256 \
    --confirm_run_unsafe_code \
    --model_args model=RedHatAI/Qwen2.5-VL-72B-Instruct-FP8-dynamic,base_url=http://0.0.0.0:8000/v1/completions,num_concurrent=32,max_retries=1,tokenized_requests=False
```

### lm_eval command
```
(lm-eval-env) (main) root@C.26291121:/workspace/lm-evaluation-harness$ HF_ALLOW_CODE_EVAL="1" lm_eval \
    --model local-completions \
    --tasks mmlu_pro_economics,ifeval,humaneval,fda,chartqa \
    --limit 256 \
    --confirm_run_unsafe_code \
    --model_args model=RedHatAI/Qwen2.5-VL-72B-Instruct-FP8-dynamic,base_url=http://0.0.0.0:8000/v1/completions,num_concurrent=32,max_retries=1,tokenized_requests=False
2025-09-28:21:03:54 WARNING  [__main__:369]  --limit SHOULD ONLY BE USED FOR TESTING.REAL METRICS SHOULD NOT BE COMPUTED USING LIMIT.
2025-09-28:21:03:54 INFO     [__main__:446] Selected Tasks: ['chartqa', 'fda', 'humaneval', 'ifeval', 'mmlu_pro_economics']
2025-09-28:21:03:54 WARNING  [evaluator:172] pretrained=model=RedHatAI/Qwen2.5-VL-72B-Instruct-FP8-dynamic,base_url=http://0.0.0.0:8000/v1/completions,num_concurrent=32,max_retries=1,tokenized_requests=False
        appears to be an instruct or chat variant but chat template is not applied. Recommend setting `apply_chat_template` (optionally
        `fewshot_as_multiturn`).
2025-09-28:21:03:54 INFO     [evaluator:202] Setting random seed to 0 | Setting numpy seed to 1234 | Setting torch manual seed to 1234 | Setting fewshot manual seed to 1234
2025-09-28:21:03:54 INFO     [evaluator:240] Initializing local-completions model, with arguments: {'model': 'RedHatAI/Qwen2.5-VL-72B-Instruct-FP8-dynamic', 'base_url':
        'http://0.0.0.0:8000/v1/completions', 'num_concurrent': 32, 'max_retries': 1, 'tokenized_requests': False}
2025-09-28:21:03:54 INFO     [models.api_models:170] Using max length 2048 - 1
2025-09-28:21:03:54 INFO     [models.api_models:189] Using tokenizer huggingface
2025-09-28:21:04:14 WARNING  [api.task:132] None: No `generation_kwargs` specified in task config, defaulting to {'until': ['\n\n'], 'do_sample': False, 'temperature': 0}
2025-09-28:21:04:21 INFO     [evaluator:305] mmlu_pro_economics: Using gen_kwargs: {'until': ['Question:'], 'max_gen_toks': 2048, 'do_sample': False, 'temperature': 0.0}
2025-09-28:21:04:21 INFO     [evaluator:305] ifeval: Using gen_kwargs: {'until': [], 'do_sample': False, 'temperature': 0.0, 'max_gen_toks': 1280}
2025-09-28:21:04:21 INFO     [evaluator:305] humaneval: Using gen_kwargs: {'until': ['\nclass', '\ndef', '\n#', '\nif', '\nprint'], 'max_gen_toks': 1024, 'do_sample': False}
2025-09-28:21:04:21 INFO     [evaluator:305] fda: Using gen_kwargs: {'until': ['\n\n'], 'do_sample': False, 'temperature': 0}
2025-09-28:21:04:21 INFO     [evaluator:305] chartqa: Using gen_kwargs: {'until': [], 'temperature': 0.0, 'do_sample': False, 'max_gen_toks': 512}
2025-09-28:21:04:21 INFO     [api.task:434] Building contexts for mmlu_pro_economics on rank 0...
100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [00:00<00:00, 746.57it/s]
2025-09-28:21:04:21 INFO     [api.task:434] Building contexts for ifeval on rank 0...
100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [00:00<00:00, 101191.39it/s]
2025-09-28:21:04:21 INFO     [api.task:434] Building contexts for humaneval on rank 0...
100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 164/164 [00:00<00:00, 2761.78it/s]
2025-09-28:21:04:21 INFO     [api.task:434] Building contexts for fda on rank 0...
100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [00:00<00:00, 235108.79it/s]
2025-09-28:21:04:21 INFO     [api.task:434] Building contexts for chartqa on rank 0...
100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [00:00<00:00, 1912.49it/s]
2025-09-28:21:04:23 INFO     [evaluator:574] Running generate_until requests
2025-09-28:21:04:23 INFO     [models.api_models:692] Tokenized requests are disabled. Context + generation length is not checked.
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [16:58<00:00,  3.98s/it]
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [04:31<00:00,  1.06s/it]
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 164/164 [00:43<00:00,  3.80it/s]
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [04:25<00:00,  1.04s/it]
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [04:37<00:00,  1.08s/it]
2025-09-28:21:36:56 INFO     [loggers.evaluation_tracker:280] Output path not provided, skipping saving results aggregated
local-completions (model=RedHatAI/Qwen2.5-VL-72B-Instruct-FP8-dynamic,base_url=http://0.0.0.0:8000/v1/completions,num_concurrent=32,max_retries=1,tokenized_requests=False), gen_kwargs: (None), limit: 256.0, num_fewshot: None, batch_size: 1
```

### results
```
|  Tasks  |Version|    Filter    |n-shot|        Metric         |   |Value |   |Stderr|
|---------|------:|--------------|-----:|-----------------------|---|-----:|---|------|
|chartqa  |    0.0|none          |     0|anywhere_accuracy      |↑  |0.0742|±  |0.0164|
|         |       |none          |     0|exact_match            |↑  |0.0586|±  |0.0147|
|         |       |none          |     0|relaxed_accuracy       |↑  |0.0703|±  |0.0160|
|fda      |    0.0|none          |     0|contains               |↑  |0.7500|±  |   N/A|
|humaneval|    1.0|create_test   |     0|pass@1                 |   |0.7195|±  |0.0352|
|ifeval   |    4.0|none          |     0|inst_level_loose_acc   |↑  |0.8299|±  |   N/A|
|         |       |none          |     0|inst_level_strict_acc  |↑  |0.7665|±  |   N/A|
|         |       |none          |     0|prompt_level_loose_acc |↑  |0.7461|±  |0.0273|
|         |       |none          |     0|prompt_level_strict_acc|↑  |0.6562|±  |0.0297|
|economics|    2.1|custom-extract|     5|exact_match            |↑  |0.8086|±  |0.0246|
```

## Qwen/Qwen2.5-VL-72B-Instruct-AWQ
### vllm serve
```sh
uv venv vllm-env --python 3.12 --seed
source vllm-env/bin/activate
uv pip install vllm --torch-backend=auto
pip uninstall pynvml
pip install flashinfer-python nvidia-ml-py
vllm serve Qwen/Qwen2.5-VL-72B-Instruct-AWQ \
    --tensor-parallel-size 4 \
    --gpu-memory-utilization 0.90 \
    --swap-space 0 \
    --kv-cache-dtype fp8 \
    --max-model-len 49152
```

### lm_eval command
```
(lm-eval-env) (main) root@C.26291121:/workspace/lm-evaluation-harness$ HF_ALLOW_CODE_EVAL="1" lm_eval \
    --model local-completions \
    --tasks mmlu_pro_economics,ifeval,humaneval,fda,chartqa \
    --limit 256 \
    --confirm_run_unsafe_code \
    --model_args model=Qwen/Qwen2.5-VL-72B-Instruct-AWQ,base_url=http://0.0.0.0:8000/v1/completions,num_concurrent=32,max_retries=1,tokenized_requests=False
2025-09-28:21:46:59 WARNING  [__main__:369]  --limit SHOULD ONLY BE USED FOR TESTING.REAL METRICS SHOULD NOT BE COMPUTED USING LIMIT.
2025-09-28:21:46:59 INFO     [__main__:446] Selected Tasks: ['chartqa', 'fda', 'humaneval', 'ifeval', 'mmlu_pro_economics']
2025-09-28:21:46:59 WARNING  [evaluator:172] pretrained=model=Qwen/Qwen2.5-VL-72B-Instruct-AWQ,base_url=http://0.0.0.0:8000/v1/completions,num_concurrent=32,max_retries=1,tokenized_requests=False
        appears to be an instruct or chat variant but chat template is not applied. Recommend setting `apply_chat_template` (optionally
        `fewshot_as_multiturn`).
2025-09-28:21:46:59 INFO     [evaluator:202] Setting random seed to 0 | Setting numpy seed to 1234 | Setting torch manual seed to 1234 | Setting fewshot manual seed to 1234
2025-09-28:21:46:59 INFO     [evaluator:240] Initializing local-completions model, with arguments: {'model': 'Qwen/Qwen2.5-VL-72B-Instruct-AWQ', 'base_url':
        'http://0.0.0.0:8000/v1/completions', 'num_concurrent': 32, 'max_retries': 1, 'tokenized_requests': False}
2025-09-28:21:46:59 INFO     [models.api_models:170] Using max length 2048 - 1
2025-09-28:21:46:59 INFO     [models.api_models:189] Using tokenizer huggingface
2025-09-28:21:47:19 WARNING  [api.task:132] None: No `generation_kwargs` specified in task config, defaulting to {'until': ['\n\n'], 'do_sample': False, 'temperature': 0}
2025-09-28:21:47:26 INFO     [evaluator:305] mmlu_pro_economics: Using gen_kwargs: {'until': ['Question:'], 'max_gen_toks': 2048, 'do_sample': False, 'temperature': 0.0}
2025-09-28:21:47:26 INFO     [evaluator:305] ifeval: Using gen_kwargs: {'until': [], 'do_sample': False, 'temperature': 0.0, 'max_gen_toks': 1280}
2025-09-28:21:47:26 INFO     [evaluator:305] humaneval: Using gen_kwargs: {'until': ['\nclass', '\ndef', '\n#', '\nif', '\nprint'], 'max_gen_toks': 1024, 'do_sample': False}
2025-09-28:21:47:26 INFO     [evaluator:305] fda: Using gen_kwargs: {'until': ['\n\n'], 'do_sample': False, 'temperature': 0}
2025-09-28:21:47:26 INFO     [evaluator:305] chartqa: Using gen_kwargs: {'until': [], 'temperature': 0.0, 'do_sample': False, 'max_gen_toks': 512}
2025-09-28:21:47:26 INFO     [api.task:434] Building contexts for mmlu_pro_economics on rank 0...
100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [00:00<00:00, 717.10it/s]
2025-09-28:21:47:26 INFO     [api.task:434] Building contexts for ifeval on rank 0...
100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [00:00<00:00, 98553.63it/s]
2025-09-28:21:47:26 INFO     [api.task:434] Building contexts for humaneval on rank 0...
100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 164/164 [00:00<00:00, 2509.60it/s]
2025-09-28:21:47:27 INFO     [api.task:434] Building contexts for fda on rank 0...
100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [00:00<00:00, 209592.39it/s]
2025-09-28:21:47:27 INFO     [api.task:434] Building contexts for chartqa on rank 0...
100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [00:00<00:00, 1826.50it/s]
2025-09-28:21:47:28 INFO     [evaluator:574] Running generate_until requests
2025-09-28:21:47:28 INFO     [models.api_models:692] Tokenized requests are disabled. Context + generation length is not checked.
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [17:01<00:00,  3.99s/it]
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [03:24<00:00,  1.25it/s]
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 164/164 [00:58<00:00,  2.82it/s]
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [08:02<00:00,  1.88s/it]
Requesting API: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 256/256 [04:49<00:00,  1.13s/it]
2025-09-28:22:23:01 INFO     [loggers.evaluation_tracker:280] Output path not provided, skipping saving results aggregated
local-completions (model=Qwen/Qwen2.5-VL-72B-Instruct-AWQ,base_url=http://0.0.0.0:8000/v1/completions,num_concurrent=32,max_retries=1,tokenized_requests=False), gen_kwargs: (None), limit: 256.0, num_fewshot: None, batch_size: 1
```

### results
```
|  Tasks  |Version|    Filter    |n-shot|        Metric         |   |Value |   |Stderr|
|---------|------:|--------------|-----:|-----------------------|---|-----:|---|------|
|chartqa  |    0.0|none          |     0|anywhere_accuracy      |↑  |0.0742|±  |0.0164|
|         |       |none          |     0|exact_match            |↑  |0.0273|±  |0.0102|
|         |       |none          |     0|relaxed_accuracy       |↑  |0.0547|±  |0.0142|
|fda      |    0.0|none          |     0|contains               |↑  |0.7422|±  |   N/A|
|humaneval|    1.0|create_test   |     0|pass@1                 |   |0.6646|±  |0.0370|
|ifeval   |    4.0|none          |     0|inst_level_loose_acc   |↑  |0.8731|±  |   N/A|
|         |       |none          |     0|inst_level_strict_acc  |↑  |0.8071|±  |   N/A|
|         |       |none          |     0|prompt_level_loose_acc |↑  |0.8125|±  |0.0244|
|         |       |none          |     0|prompt_level_strict_acc|↑  |0.7148|±  |0.0283|
|economics|    2.1|custom-extract|     5|exact_match            |↑  |0.7969|±  |0.0252|
```