# Hosting Qwen3-235B-A22B-Instruct-2507-FP8 on 8xL40S
```sh
vllm serve Qwen/Qwen3-235B-A22B-Instruct-2507-FP8 \
    --tensor-parallel-size 4 \
    --enable-expert-parallel \
    --gpu-memory-utilization 0.90 \
    --swap-space 0 \
    --max-model-len 32K
```

```
(Worker_TP3_EP3 pid=2081) INFO 09-24 20:53:41 [gpu_worker.py:298] Available KV cache memory: 10.65 GiB
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:864] GPU KV cache size: 238,208 tokens
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 7.27x

(Worker_TP2_EP2 pid=2080) INFO 09-24 20:54:35 [gpu_worker.py:391] Free memory on device (43.93/44.42 GiB) on startup. Desired GPU memory utilization is (0.9, 39.98 GiB). Actual usage is 27.72 GiB for weight, 1.4 GiB for peak activation, 0.21 GiB for non-torch memory, and 3.45 GiB for CUDAGraph memory. Replace gpu_memory_utilization config with `--kv-cache-memory=7564378828` to fit into requested memory, or `--kv-cache-memory=11809093120` to fully utilize gpu memory. Current kv cache memory in use is 11423138508 bytes.

Wed Sep 24 21:05:11 2025
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 565.57.01              Driver Version: 565.57.01      CUDA Version: 12.7     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA L40S                    On  |   00000000:4F:00.0 Off |                    0 |
| N/A   48C    P0            155W /  350W |   45397MiB /  46068MiB |     95%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
|   1  NVIDIA L40S                    On  |   00000000:52:00.0 Off |                    0 |
| N/A   50C    P0            170W /  350W |   45249MiB /  46068MiB |     96%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
|   2  NVIDIA L40S                    On  |   00000000:56:00.0 Off |                    0 |
| N/A   43C    P0            139W /  350W |   45249MiB /  46068MiB |     96%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
|   3  NVIDIA L40S                    On  |   00000000:57:00.0 Off |                    0 |
| N/A   49C    P0            162W /  350W |   45241MiB /  46068MiB |     95%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
|   4  NVIDIA L40S                    On  |   00000000:D1:00.0 Off |                    0 |
| N/A   49C    P0            173W /  350W |   45397MiB /  46068MiB |     95%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
|   5  NVIDIA L40S                    On  |   00000000:D2:00.0 Off |                    0 |
| N/A   49C    P0            167W /  350W |   45249MiB /  46068MiB |     96%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
|   6  NVIDIA L40S                    On  |   00000000:D5:00.0 Off |                    0 |
| N/A   48C    P0            144W /  350W |   45249MiB /  46068MiB |     95%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
|   7  NVIDIA L40S                    On  |   00000000:D6:00.0 Off |                    0 |
| N/A   48C    P0            148W /  350W |   45241MiB /  46068MiB |     95%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+

+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|    0   N/A  N/A      2078      C   VLLM::Worker_TP0_EP0                        45388MiB |
|    1   N/A  N/A      2079      C   VLLM::Worker_TP1_EP1                        45240MiB |
|    2   N/A  N/A      2080      C   VLLM::Worker_TP2_EP2                        45240MiB |
|    3   N/A  N/A      2081      C   VLLM::Worker_TP3_EP3                        45232MiB |
|    4   N/A  N/A      2082      C   VLLM::Worker_TP4_EP4                        45388MiB |
|    5   N/A  N/A      2083      C   VLLM::Worker_TP5_EP5                        45240MiB |
|    6   N/A  N/A      2084      C   VLLM::Worker_TP6_EP6                        45240MiB |
|    7   N/A  N/A      2085      C   VLLM::Worker_TP7_EP7                        45232MiB |
+-----------------------------------------------------------------------------------------+
```
## 1 request
```
[0001] <stream complete> (57.335 sec) (2227 tokens) (38.842 tokens/sec)

All threads finished.
CPU times: user 224 ms, sys: 84.7 ms, total: 308 ms
Wall time: 57.3 s
```

## 8 parallel requests
```
[0005] <stream complete> (80.422 sec) (1852 tokens) (23.029 tokens/sec)
[0004] <stream complete> (83.931 sec) (1927 tokens) (22.959 tokens/sec)
[0003] <stream complete> (84.248 sec) (1941 tokens) (23.039 tokens/sec)
[0007] <stream complete> (86.637 sec) (1984 tokens) (22.900 tokens/sec)
[0006] <stream complete> (88.285 sec) (2031 tokens) (23.005 tokens/sec)
[0001] <stream complete> (90.108 sec) (2079 tokens) (23.072 tokens/sec)
[0002] <stream complete> (92.084 sec) (2149 tokens) (23.337 tokens/sec)
[0008] <stream complete> (92.656 sec) (2169 tokens) (23.409 tokens/sec)

All threads finished.
CPU times: user 1.82 s, sys: 915 ms, total: 2.74 s
Wall time: 1min 32s
```

## 32 parallel requests
```
[0015] <stream complete> (148.216 sec) (1792 tokens) (12.090 tokens/sec)
[0019] <stream complete> (155.289 sec) (1871 tokens) (12.048 tokens/sec)
[0024] <stream complete> (155.618 sec) (1866 tokens) (11.991 tokens/sec)
[0023] <stream complete> (158.642 sec) (1901 tokens) (11.983 tokens/sec)
[0010] <stream complete> (158.773 sec) (1910 tokens) (12.030 tokens/sec)
[0026] <stream complete> (158.721 sec) (1903 tokens) (11.990 tokens/sec)
[0011] <stream complete> (160.502 sec) (1920 tokens) (11.963 tokens/sec)
[0031] <stream complete> (160.524 sec) (1929 tokens) (12.017 tokens/sec)
[0001] <stream complete> (160.832 sec) (1921 tokens) (11.944 tokens/sec)
[0025] <stream complete> (160.905 sec) (1936 tokens) (12.032 tokens/sec)
[0028] <stream complete> (163.919 sec) (1964 tokens) (11.981 tokens/sec)
[0017] <stream complete> (164.172 sec) (1982 tokens) (12.073 tokens/sec)
[0027] <stream complete> (165.321 sec) (1994 tokens) (12.061 tokens/sec)
[0018] <stream complete> (165.946 sec) (1995 tokens) (12.022 tokens/sec)
[0003] <stream complete> (166.068 sec) (2005 tokens) (12.073 tokens/sec)
[0030] <stream complete> (168.864 sec) (2040 tokens) (12.081 tokens/sec)
[0029] <stream complete> (169.503 sec) (2046 tokens) (12.071 tokens/sec)
[0022] <stream complete> (170.465 sec) (2059 tokens) (12.079 tokens/sec)
[0004] <stream complete> (170.705 sec) (2073 tokens) (12.144 tokens/sec)
[0016] <stream complete> (170.918 sec) (2075 tokens) (12.140 tokens/sec)
[0007] <stream complete> (170.948 sec) (2072 tokens) (12.121 tokens/sec)
[0021] <stream complete> (171.889 sec) (2085 tokens) (12.130 tokens/sec)
[0020] <stream complete> (172.391 sec) (2088 tokens) (12.112 tokens/sec)
[0012] <stream complete> (172.917 sec) (2102 tokens) (12.156 tokens/sec)
[0009] <stream complete> (173.533 sec) (2120 tokens) (12.217 tokens/sec)
[0008] <stream complete> (176.847 sec) (2196 tokens) (12.418 tokens/sec)
[0006] <stream complete> (177.355 sec) (2203 tokens) (12.421 tokens/sec)
[0014] <stream complete> (177.469 sec) (2208 tokens) (12.442 tokens/sec)
[0005] <stream complete> (178.138 sec) (2226 tokens) (12.496 tokens/sec)
[0002] <stream complete> (180.393 sec) (2285 tokens) (12.667 tokens/sec)
[0013] <stream complete> (180.518 sec) (2293 tokens) (12.702 tokens/sec)
[0032] <stream complete> (186.282 sec) (2520 tokens) (13.528 tokens/sec)

All threads finished.
CPU times: user 7.09 s, sys: 3.3 s, total: 10.4 s
Wall time: 3min 6s
```

## vllm logs
(workspace) (main) root@C.26184898:/workspace$ vllm serve Qwen/Qwen3-235B-A22B-Instruct-2507-FP8 \
    --tensor-parallel-size 8 \
    --enable-expert-parallel \
    --gpu-memory-utilization 0.90 \
    --swap-space 0 \
    --max-model-len 32K
INFO 09-24 20:45:36 [__init__.py:216] Automatically detected platform cuda.
(APIServer pid=1624) INFO 09-24 20:45:41 [api_server.py:1896] vLLM API server version 0.10.2
(APIServer pid=1624) INFO 09-24 20:45:41 [utils.py:328] non-default args: {'model_tag': 'Qwen/Qwen3-235B-A22B-Instruct-2507-FP8', 'model': 'Qwen/Qwen3-235B-A22B-Instruct-2507-FP8', 'max_model_len': 32768, 'tensor_parallel_size': 8, 'enable_expert_parallel': True, 'swap_space': 0.0}
config.json: 12.9kB [00:00, 19.4MB/s]
(APIServer pid=1624) INFO 09-24 20:45:48 [__init__.py:742] Resolved architecture: Qwen3MoeForCausalLM
(APIServer pid=1624) `torch_dtype` is deprecated! Use `dtype` instead!
(APIServer pid=1624) INFO 09-24 20:45:48 [__init__.py:1815] Using max model len 32768
(APIServer pid=1624) WARNING 09-24 20:45:49 [_ipex_ops.py:16] Import error msg: No module named 'intel_extension_for_pytorch'
(APIServer pid=1624) INFO 09-24 20:45:49 [scheduler.py:222] Chunked prefill is enabled with max_num_batched_tokens=2048.
tokenizer_config.json: 9.38kB [00:00, 17.2MB/s]
vocab.json: 2.78MB [00:00, 69.9MB/s]
merges.txt: 1.67MB [00:00, 56.0MB/s]
tokenizer.json: 100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████| 11.4M/11.4M [00:00<00:00, 21.4MB/s]
generation_config.json: 100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████| 239/239 [00:00<00:00, 1.03MB/s]
INFO 09-24 20:45:56 [__init__.py:216] Automatically detected platform cuda.
(EngineCore_DP0 pid=1944) INFO 09-24 20:45:58 [core.py:654] Waiting for init message from front-end.
(EngineCore_DP0 pid=1944) INFO 09-24 20:45:58 [core.py:76] Initializing a V1 LLM engine (v0.10.2) with config: model='Qwen/Qwen3-235B-A22B-Instruct-2507-FP8', speculative_config=None, tokenizer='Qwen/Qwen3-235B-A22B-Instruct-2507-FP8', skip_tokenizer_init=False, tokenizer_mode=auto, revision=None, tokenizer_revision=None, trust_remote_code=False, dtype=torch.bfloat16, max_seq_len=32768, download_dir=None, load_format=auto, tensor_parallel_size=8, pipeline_parallel_size=1, data_parallel_size=1, disable_custom_all_reduce=False, quantization=fp8, enforce_eager=False, kv_cache_dtype=auto, device_config=cuda, decoding_config=DecodingConfig(backend='auto', disable_fallback=False, disable_any_whitespace=False, disable_additional_properties=False, reasoning_backend=''), observability_config=ObservabilityConfig(show_hidden_metrics_for_version=None, otlp_traces_endpoint=None, collect_detailed_traces=None), seed=0, served_model_name=Qwen/Qwen3-235B-A22B-Instruct-2507-FP8, enable_prefix_caching=True, chunked_prefill_enabled=True, use_async_output_proc=True, pooler_config=None, compilation_config={"level":3,"debug_dump_path":"","cache_dir":"","backend":"","custom_ops":[],"splitting_ops":["vllm.unified_attention","vllm.unified_attention_with_output","vllm.mamba_mixer2","vllm.mamba_mixer","vllm.short_conv","vllm.linear_attention","vllm.plamo2_mamba_mixer","vllm.gdn_attention"],"use_inductor":true,"compile_sizes":[],"inductor_compile_config":{"enable_auto_functionalized_v2":false},"inductor_passes":{},"cudagraph_mode":1,"use_cudagraph":true,"cudagraph_num_of_warmups":1,"cudagraph_capture_sizes":[512,504,496,488,480,472,464,456,448,440,432,424,416,408,400,392,384,376,368,360,352,344,336,328,320,312,304,296,288,280,272,264,256,248,240,232,224,216,208,200,192,184,176,168,160,152,144,136,128,120,112,104,96,88,80,72,64,56,48,40,32,24,16,8,4,2,1],"cudagraph_copy_inputs":false,"full_cuda_graph":false,"pass_config":{},"max_capture_size":512,"local_cache_dir":null}
(EngineCore_DP0 pid=1944) WARNING 09-24 20:45:58 [multiproc_worker_utils.py:273] Reducing Torch parallelism from 32 threads to 1 to avoid unnecessary CPU contention. Set OMP_NUM_THREADS in the external environment to tune this value as needed.
(EngineCore_DP0 pid=1944) INFO 09-24 20:45:58 [shm_broadcast.py:289] vLLM message queue communication handle: Handle(local_reader_ranks=[0, 1, 2, 3, 4, 5, 6, 7], buffer_handle=(8, 16777216, 10, 'psm_7b04b2e3'), local_subscribe_addr='ipc:///tmp/badbc2f6-cf11-430c-82ff-c260808e5c22', remote_subscribe_addr=None, remote_addr_ipv6=False)
INFO 09-24 20:46:03 [__init__.py:216] Automatically detected platform cuda.
INFO 09-24 20:46:03 [__init__.py:216] Automatically detected platform cuda.
INFO 09-24 20:46:03 [__init__.py:216] Automatically detected platform cuda.
INFO 09-24 20:46:03 [__init__.py:216] Automatically detected platform cuda.
INFO 09-24 20:46:03 [__init__.py:216] Automatically detected platform cuda.
INFO 09-24 20:46:03 [__init__.py:216] Automatically detected platform cuda.
INFO 09-24 20:46:03 [__init__.py:216] Automatically detected platform cuda.
INFO 09-24 20:46:03 [__init__.py:216] Automatically detected platform cuda.
INFO 09-24 20:46:09 [shm_broadcast.py:289] vLLM message queue communication handle: Handle(local_reader_ranks=[0], buffer_handle=(1, 10485760, 10, 'psm_9d466f0a'), local_subscribe_addr='ipc:///tmp/ca7f85a3-ef40-475b-ac02-4a1504d219cb', remote_subscribe_addr=None, remote_addr_ipv6=False)
INFO 09-24 20:46:09 [shm_broadcast.py:289] vLLM message queue communication handle: Handle(local_reader_ranks=[0], buffer_handle=(1, 10485760, 10, 'psm_0049e2b5'), local_subscribe_addr='ipc:///tmp/9fce6f65-a4d7-4895-932c-75331edf664b', remote_subscribe_addr=None, remote_addr_ipv6=False)
INFO 09-24 20:46:09 [shm_broadcast.py:289] vLLM message queue communication handle: Handle(local_reader_ranks=[0], buffer_handle=(1, 10485760, 10, 'psm_e07940c4'), local_subscribe_addr='ipc:///tmp/bf6ff20f-4b5d-4e83-8e31-3ff6fcd19548', remote_subscribe_addr=None, remote_addr_ipv6=False)
INFO 09-24 20:46:09 [shm_broadcast.py:289] vLLM message queue communication handle: Handle(local_reader_ranks=[0], buffer_handle=(1, 10485760, 10, 'psm_9e331185'), local_subscribe_addr='ipc:///tmp/886c80ea-d017-473d-adff-bce54bbbe4f1', remote_subscribe_addr=None, remote_addr_ipv6=False)
INFO 09-24 20:46:09 [shm_broadcast.py:289] vLLM message queue communication handle: Handle(local_reader_ranks=[0], buffer_handle=(1, 10485760, 10, 'psm_113d848f'), local_subscribe_addr='ipc:///tmp/dd1feef6-008f-4a20-a5cd-12527094c0d0', remote_subscribe_addr=None, remote_addr_ipv6=False)
INFO 09-24 20:46:09 [shm_broadcast.py:289] vLLM message queue communication handle: Handle(local_reader_ranks=[0], buffer_handle=(1, 10485760, 10, 'psm_0d3ab17e'), local_subscribe_addr='ipc:///tmp/587b7a5b-d1cd-4461-82e2-c698dd191bb5', remote_subscribe_addr=None, remote_addr_ipv6=False)
INFO 09-24 20:46:09 [shm_broadcast.py:289] vLLM message queue communication handle: Handle(local_reader_ranks=[0], buffer_handle=(1, 10485760, 10, 'psm_8dc83f11'), local_subscribe_addr='ipc:///tmp/df9f0ce5-2192-4971-9a74-3dde51cfa25c', remote_subscribe_addr=None, remote_addr_ipv6=False)
INFO 09-24 20:46:09 [shm_broadcast.py:289] vLLM message queue communication handle: Handle(local_reader_ranks=[0], buffer_handle=(1, 10485760, 10, 'psm_3c3ecb9b'), local_subscribe_addr='ipc:///tmp/e1f8d5e2-8e32-487a-a2ac-fd7b789797d3', remote_subscribe_addr=None, remote_addr_ipv6=False)
[W924 20:46:10.978323979 ProcessGroupNCCL.cpp:981] Warning: TORCH_NCCL_AVOID_RECORD_STREAMS is the default now, this environment variable is thus deprecated. (function operator())
[W924 20:46:10.980935838 ProcessGroupNCCL.cpp:981] Warning: TORCH_NCCL_AVOID_RECORD_STREAMS is the default now, this environment variable is thus deprecated. (function operator())
[W924 20:46:10.981260123 ProcessGroupNCCL.cpp:981] Warning: TORCH_NCCL_AVOID_RECORD_STREAMS is the default now, this environment variable is thus deprecated. (function operator())
[W924 20:46:10.988064337 ProcessGroupNCCL.cpp:981] Warning: TORCH_NCCL_AVOID_RECORD_STREAMS is the default now, this environment variable is thus deprecated. (function operator())
[W924 20:46:10.032915684 ProcessGroupNCCL.cpp:981] Warning: TORCH_NCCL_AVOID_RECORD_STREAMS is the default now, this environment variable is thus deprecated. (function operator())
[W924 20:46:10.033089227 ProcessGroupNCCL.cpp:981] Warning: TORCH_NCCL_AVOID_RECORD_STREAMS is the default now, this environment variable is thus deprecated. (function operator())
[W924 20:46:10.033369002 ProcessGroupNCCL.cpp:981] Warning: TORCH_NCCL_AVOID_RECORD_STREAMS is the default now, this environment variable is thus deprecated. (function operator())
[W924 20:46:10.043809957 ProcessGroupNCCL.cpp:981] Warning: TORCH_NCCL_AVOID_RECORD_STREAMS is the default now, this environment variable is thus deprecated. (function operator())
[Gloo] Rank 0 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
[Gloo] Rank 1 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
[Gloo] Rank 3 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
[Gloo] Rank 5 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
[Gloo] Rank 2 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
[Gloo] Rank 4 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
[Gloo] Rank 6 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
[Gloo] Rank 7 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
[Gloo] Rank 0 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
[Gloo] Rank 2 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
[Gloo] Rank 1 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
[Gloo] Rank 4 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
[Gloo] Rank 6[Gloo] Rank  is connected to 77 peer ranks.  is connected to Expected number of connected peer ranks is : 77 peer ranks. 
Expected number of connected peer ranks is : 7
[Gloo] Rank 5 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7[Gloo] Rank 
3 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
INFO 09-24 20:46:10 [__init__.py:1433] Found nccl from library libnccl.so.2
INFO 09-24 20:46:10 [pynccl.py:70] vLLM is using nccl==2.27.3
INFO 09-24 20:46:10 [__init__.py:1433] Found nccl from library libnccl.so.2
INFO 09-24 20:46:10 [pynccl.py:70] vLLM is using nccl==2.27.3
INFO 09-24 20:46:10 [__init__.py:1433] Found nccl from library libnccl.so.2
INFO 09-24 20:46:10 [pynccl.py:70] vLLM is using nccl==2.27.3
INFO 09-24 20:46:10 [__init__.py:1433] Found nccl from library libnccl.so.2
INFO 09-24 20:46:10 [pynccl.py:70] vLLM is using nccl==2.27.3
INFO 09-24 20:46:10 [__init__.py:1433] Found nccl from library libnccl.so.2
INFO 09-24 20:46:10 [pynccl.py:70] vLLM is using nccl==2.27.3
INFO 09-24 20:46:10 [__init__.py:1433] Found nccl from library libnccl.so.2
INFO 09-24 20:46:10 [pynccl.py:70] vLLM is using nccl==2.27.3
INFO 09-24 20:46:10 [__init__.py:1433] Found nccl from library libnccl.so.2
INFO 09-24 20:46:10 [pynccl.py:70] vLLM is using nccl==2.27.3
INFO 09-24 20:46:10 [__init__.py:1433] Found nccl from library libnccl.so.2
INFO 09-24 20:46:10 [pynccl.py:70] vLLM is using nccl==2.27.3
WARNING 09-24 20:46:11 [custom_all_reduce.py:144] Custom allreduce is disabled because it's not supported on more than two PCIe-only GPUs. To silence this warning, specify disable_custom_all_reduce=True explicitly.
WARNING 09-24 20:46:11 [custom_all_reduce.py:144] Custom allreduce is disabled because it's not supported on more than two PCIe-only GPUs. To silence this warning, specify disable_custom_all_reduce=True explicitly.
WARNING 09-24 20:46:11 [custom_all_reduce.py:144] Custom allreduce is disabled because it's not supported on more than two PCIe-only GPUs. To silence this warning, specify disable_custom_all_reduce=True explicitly.
WARNING 09-24 20:46:11 [custom_all_reduce.py:144] Custom allreduce is disabled because it's not supported on more than two PCIe-only GPUs. To silence this warning, specify disable_custom_all_reduce=True explicitly.
WARNING 09-24 20:46:11 [custom_all_reduce.py:144] Custom allreduce is disabled because it's not supported on more than two PCIe-only GPUs. To silence this warning, specify disable_custom_all_reduce=True explicitly.
WARNING 09-24 20:46:11 [custom_all_reduce.py:144] Custom allreduce is disabled because it's not supported on more than two PCIe-only GPUs. To silence this warning, specify disable_custom_all_reduce=True explicitly.
WARNING 09-24 20:46:11 [custom_all_reduce.py:144] Custom allreduce is disabled because it's not supported on more than two PCIe-only GPUs. To silence this warning, specify disable_custom_all_reduce=True explicitly.
WARNING 09-24 20:46:11 [custom_all_reduce.py:144] Custom allreduce is disabled because it's not supported on more than two PCIe-only GPUs. To silence this warning, specify disable_custom_all_reduce=True explicitly.
INFO 09-24 20:46:11 [shm_broadcast.py:289] vLLM message queue communication handle: Handle(local_reader_ranks=[1, 2, 3, 4, 5, 6, 7], buffer_handle=(7, 4194304, 6, 'psm_8544af4a'), local_subscribe_addr='ipc:///tmp/fa52b418-06cb-40a7-b68e-c1a98f187c58', remote_subscribe_addr=None, remote_addr_ipv6=False)
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0[Gloo] Rank  is connected to 00 peer ranks.  is connected to Expected number of connected peer ranks is : 00 peer ranks. [Gloo] Rank Expected number of connected peer ranks is : 
00 is connected to 
0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : [Gloo] Rank 0
0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. [Gloo] Rank Expected number of connected peer ranks is : 00
 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 0 peer ranks. Expected number of connected peer ranks is : 0
[Gloo] Rank 0 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
[Gloo] Rank 1 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
[Gloo] Rank 4 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
[Gloo] Rank 3 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
[Gloo] Rank 6 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
INFO 09-24 20:46:11 [parallel_state.py:1165] rank 0 in world size 8 is assigned as DP rank 0, PP rank 0, TP rank 0, EP rank 0
[Gloo] Rank 2 is connected to 7 peer ranks. Expected number of connected peer ranks is : 7
[Gloo] Rank 7 is connected to 7 peer ranks. [Gloo] Rank Expected number of connected peer ranks is : 57 is connected to 
7 peer ranks. Expected number of connected peer ranks is : 7
INFO 09-24 20:46:11 [parallel_state.py:1165] rank 1 in world size 8 is assigned as DP rank 0, PP rank 0, TP rank 1, EP rank 1
INFO 09-24 20:46:11 [parallel_state.py:1165] rank 4 in world size 8 is assigned as DP rank 0, PP rank 0, TP rank 4, EP rank 4
INFO 09-24 20:46:11 [parallel_state.py:1165] rank 3 in world size 8 is assigned as DP rank 0, PP rank 0, TP rank 3, EP rank 3
INFO 09-24 20:46:11 [parallel_state.py:1165] rank 2 in world size 8 is assigned as DP rank 0, PP rank 0, TP rank 2, EP rank 2
INFO 09-24 20:46:11 [parallel_state.py:1165] rank 6 in world size 8 is assigned as DP rank 0, PP rank 0, TP rank 6, EP rank 6
INFO 09-24 20:46:11 [parallel_state.py:1165] rank 7 in world size 8 is assigned as DP rank 0, PP rank 0, TP rank 7, EP rank 7
INFO 09-24 20:46:11 [parallel_state.py:1165] rank 5 in world size 8 is assigned as DP rank 0, PP rank 0, TP rank 5, EP rank 5
WARNING 09-24 20:46:11 [topk_topp_sampler.py:69] FlashInfer is not available. Falling back to the PyTorch-native implementation of top-p & top-k sampling. For the best performance, please install FlashInfer.
WARNING 09-24 20:46:11 [topk_topp_sampler.py:69] FlashInfer is not available. Falling back to the PyTorch-native implementation of top-p & top-k sampling. For the best performance, please install FlashInfer.
WARNING 09-24 20:46:11 [topk_topp_sampler.py:69] FlashInfer is not available. Falling back to the PyTorch-native implementation of top-p & top-k sampling. For the best performance, please install FlashInfer.
WARNING 09-24 20:46:11 [topk_topp_sampler.py:69] FlashInfer is not available. Falling back to the PyTorch-native implementation of top-p & top-k sampling. For the best performance, please install FlashInfer.
WARNING 09-24 20:46:11 [topk_topp_sampler.py:69] FlashInfer is not available. Falling back to the PyTorch-native implementation of top-p & top-k sampling. For the best performance, please install FlashInfer.
WARNING 09-24 20:46:11 [topk_topp_sampler.py:69] FlashInfer is not available. Falling back to the PyTorch-native implementation of top-p & top-k sampling. For the best performance, please install FlashInfer.
WARNING 09-24 20:46:11 [topk_topp_sampler.py:69] FlashInfer is not available. Falling back to the PyTorch-native implementation of top-p & top-k sampling. For the best performance, please install FlashInfer.
WARNING 09-24 20:46:11 [topk_topp_sampler.py:69] FlashInfer is not available. Falling back to the PyTorch-native implementation of top-p & top-k sampling. For the best performance, please install FlashInfer.
(Worker_TP7_EP7 pid=2085) INFO 09-24 20:46:11 [gpu_model_runner.py:2338] Starting to load model Qwen/Qwen3-235B-A22B-Instruct-2507-FP8...
(Worker_TP4_EP4 pid=2082) INFO 09-24 20:46:11 [gpu_model_runner.py:2338] Starting to load model Qwen/Qwen3-235B-A22B-Instruct-2507-FP8...
(Worker_TP6_EP6 pid=2084) INFO 09-24 20:46:11 [gpu_model_runner.py:2338] Starting to load model Qwen/Qwen3-235B-A22B-Instruct-2507-FP8...
(Worker_TP1_EP1 pid=2079) INFO 09-24 20:46:11 [gpu_model_runner.py:2338] Starting to load model Qwen/Qwen3-235B-A22B-Instruct-2507-FP8...
(Worker_TP3_EP3 pid=2081) INFO 09-24 20:46:11 [gpu_model_runner.py:2338] Starting to load model Qwen/Qwen3-235B-A22B-Instruct-2507-FP8...
(Worker_TP5_EP5 pid=2083) INFO 09-24 20:46:11 [gpu_model_runner.py:2338] Starting to load model Qwen/Qwen3-235B-A22B-Instruct-2507-FP8...
(Worker_TP0_EP0 pid=2078) INFO 09-24 20:46:11 [gpu_model_runner.py:2338] Starting to load model Qwen/Qwen3-235B-A22B-Instruct-2507-FP8...
(Worker_TP2_EP2 pid=2080) INFO 09-24 20:46:11 [gpu_model_runner.py:2338] Starting to load model Qwen/Qwen3-235B-A22B-Instruct-2507-FP8...
(Worker_TP0_EP0 pid=2078) INFO 09-24 20:46:11 [gpu_model_runner.py:2370] Loading model from scratch...
(Worker_TP4_EP4 pid=2082) INFO 09-24 20:46:11 [gpu_model_runner.py:2370] Loading model from scratch...
(Worker_TP6_EP6 pid=2084) INFO 09-24 20:46:11 [gpu_model_runner.py:2370] Loading model from scratch...
(Worker_TP2_EP2 pid=2080) INFO 09-24 20:46:11 [gpu_model_runner.py:2370] Loading model from scratch...
(Worker_TP7_EP7 pid=2085) INFO 09-24 20:46:11 [gpu_model_runner.py:2370] Loading model from scratch...
(Worker_TP5_EP5 pid=2083) INFO 09-24 20:46:11 [gpu_model_runner.py:2370] Loading model from scratch...
(Worker_TP4_EP4 pid=2082) INFO 09-24 20:46:11 [cuda.py:362] Using Flash Attention backend on V1 engine.
(Worker_TP0_EP0 pid=2078) INFO 09-24 20:46:11 [cuda.py:362] Using Flash Attention backend on V1 engine.
(Worker_TP3_EP3 pid=2081) INFO 09-24 20:46:11 [gpu_model_runner.py:2370] Loading model from scratch...
(Worker_TP1_EP1 pid=2079) INFO 09-24 20:46:11 [gpu_model_runner.py:2370] Loading model from scratch...
(Worker_TP6_EP6 pid=2084) INFO 09-24 20:46:11 [cuda.py:362] Using Flash Attention backend on V1 engine.
(Worker_TP2_EP2 pid=2080) INFO 09-24 20:46:11 [cuda.py:362] Using Flash Attention backend on V1 engine.
(Worker_TP7_EP7 pid=2085) INFO 09-24 20:46:11 [cuda.py:362] Using Flash Attention backend on V1 engine.
(Worker_TP4_EP4 pid=2082) INFO 09-24 20:46:11 [layer.py:853] [EP Rank 4/8] Expert parallelism is enabled. Local/global number of experts: 16/128. Experts local to global index map: 0->64, 1->65, 2->66, 3->67, 4->68, 5->69, 6->70, 7->71, 8->72, 9->73, 10->74, 11->75, 12->76, 13->77, 14->78, 15->79.
(Worker_TP0_EP0 pid=2078) INFO 09-24 20:46:11 [layer.py:853] [EP Rank 0/8] Expert parallelism is enabled. Local/global number of experts: 16/128. Experts local to global index map: 0->0, 1->1, 2->2, 3->3, 4->4, 5->5, 6->6, 7->7, 8->8, 9->9, 10->10, 11->11, 12->12, 13->13, 14->14, 15->15.
(Worker_TP4_EP4 pid=2082) WARNING 09-24 20:46:11 [fp8.py:574] CutlassBlockScaledGroupedGemm not supported on the current platform.
(Worker_TP0_EP0 pid=2078) WARNING 09-24 20:46:11 [fp8.py:574] CutlassBlockScaledGroupedGemm not supported on the current platform.
(Worker_TP6_EP6 pid=2084) INFO 09-24 20:46:11 [layer.py:853] [EP Rank 6/8] Expert parallelism is enabled. Local/global number of experts: 16/128. Experts local to global index map: 0->96, 1->97, 2->98, 3->99, 4->100, 5->101, 6->102, 7->103, 8->104, 9->105, 10->106, 11->107, 12->108, 13->109, 14->110, 15->111.
(Worker_TP6_EP6 pid=2084) WARNING 09-24 20:46:11 [fp8.py:574] CutlassBlockScaledGroupedGemm not supported on the current platform.
(Worker_TP7_EP7 pid=2085) INFO 09-24 20:46:11 [layer.py:853] [EP Rank 7/8] Expert parallelism is enabled. Local/global number of experts: 16/128. Experts local to global index map: 0->112, 1->113, 2->114, 3->115, 4->116, 5->117, 6->118, 7->119, 8->120, 9->121, 10->122, 11->123, 12->124, 13->125, 14->126, 15->127.
(Worker_TP2_EP2 pid=2080) INFO 09-24 20:46:11 [layer.py:853] [EP Rank 2/8] Expert parallelism is enabled. Local/global number of experts: 16/128. Experts local to global index map: 0->32, 1->33, 2->34, 3->35, 4->36, 5->37, 6->38, 7->39, 8->40, 9->41, 10->42, 11->43, 12->44, 13->45, 14->46, 15->47.
(Worker_TP7_EP7 pid=2085) WARNING 09-24 20:46:11 [fp8.py:574] CutlassBlockScaledGroupedGemm not supported on the current platform.
(Worker_TP2_EP2 pid=2080) WARNING 09-24 20:46:11 [fp8.py:574] CutlassBlockScaledGroupedGemm not supported on the current platform.
(Worker_TP5_EP5 pid=2083) INFO 09-24 20:46:11 [cuda.py:362] Using Flash Attention backend on V1 engine.
(Worker_TP3_EP3 pid=2081) INFO 09-24 20:46:11 [cuda.py:362] Using Flash Attention backend on V1 engine.
(Worker_TP1_EP1 pid=2079) INFO 09-24 20:46:11 [cuda.py:362] Using Flash Attention backend on V1 engine.
(Worker_TP5_EP5 pid=2083) INFO 09-24 20:46:11 [layer.py:853] [EP Rank 5/8] Expert parallelism is enabled. Local/global number of experts: 16/128. Experts local to global index map: 0->80, 1->81, 2->82, 3->83, 4->84, 5->85, 6->86, 7->87, 8->88, 9->89, 10->90, 11->91, 12->92, 13->93, 14->94, 15->95.
(Worker_TP5_EP5 pid=2083) WARNING 09-24 20:46:11 [fp8.py:574] CutlassBlockScaledGroupedGemm not supported on the current platform.
(Worker_TP1_EP1 pid=2079) INFO 09-24 20:46:11 [layer.py:853] [EP Rank 1/8] Expert parallelism is enabled. Local/global number of experts: 16/128. Experts local to global index map: 0->16, 1->17, 2->18, 3->19, 4->20, 5->21, 6->22, 7->23, 8->24, 9->25, 10->26, 11->27, 12->28, 13->29, 14->30, 15->31.
(Worker_TP1_EP1 pid=2079) WARNING 09-24 20:46:11 [fp8.py:574] CutlassBlockScaledGroupedGemm not supported on the current platform.
(Worker_TP3_EP3 pid=2081) INFO 09-24 20:46:11 [layer.py:853] [EP Rank 3/8] Expert parallelism is enabled. Local/global number of experts: 16/128. Experts local to global index map: 0->48, 1->49, 2->50, 3->51, 4->52, 5->53, 6->54, 7->55, 8->56, 9->57, 10->58, 11->59, 12->60, 13->61, 14->62, 15->63.
(Worker_TP3_EP3 pid=2081) WARNING 09-24 20:46:11 [fp8.py:574] CutlassBlockScaledGroupedGemm not supported on the current platform.
(Worker_TP4_EP4 pid=2082) INFO 09-24 20:46:12 [weight_utils.py:348] Using model weights format ['*.safetensors']
(Worker_TP2_EP2 pid=2080) INFO 09-24 20:46:12 [weight_utils.py:348] Using model weights format ['*.safetensors']
(Worker_TP7_EP7 pid=2085) INFO 09-24 20:46:12 [weight_utils.py:348] Using model weights format ['*.safetensors']
(Worker_TP0_EP0 pid=2078) INFO 09-24 20:46:12 [weight_utils.py:348] Using model weights format ['*.safetensors']
(Worker_TP5_EP5 pid=2083) INFO 09-24 20:46:12 [weight_utils.py:348] Using model weights format ['*.safetensors']
(Worker_TP3_EP3 pid=2081) INFO 09-24 20:46:12 [weight_utils.py:348] Using model weights format ['*.safetensors']
(Worker_TP1_EP1 pid=2079) INFO 09-24 20:46:12 [weight_utils.py:348] Using model weights format ['*.safetensors']
(Worker_TP6_EP6 pid=2084) INFO 09-24 20:46:12 [weight_utils.py:348] Using model weights format ['*.safetensors']
model-00003-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:26<00:00, 115MB/s]
model-00001-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:27<00:00, 115MB/s]
model-00002-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:27<00:00, 115MB/s]
model-00005-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:34<00:00, 106MB/s]
model-00004-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:39<00:00, 101MB/s]
model-00008-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:39<00:00, 101MB/s]
model-00006-of-00024.safetensors: 100%|███████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:40<00:00, 99.7MB/s]
model-00007-of-00024.safetensors: 100%|███████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:41<00:00, 98.3MB/s]
model-00009-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:15<00:00, 132MB/s]
model-00010-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:24<00:00, 118MB/s]
model-00011-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:26<00:00, 115MB/s]
model-00012-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:29<00:00, 111MB/s]
model-00013-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:32<00:00, 108MB/s]
model-00014-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:32<00:00, 108MB/s]
model-00015-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:32<00:00, 108MB/s]
model-00016-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:32<00:00, 108MB/s]
model-00017-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:28<00:00, 113MB/s]
model-00024-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 6.45G/6.45G [01:02<00:00, 103MB/s]
model-00018-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:27<00:00, 114MB/s]
model-00019-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:26<00:00, 116MB/s]
model-00020-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:22<00:00, 121MB/s]
model-00021-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:18<00:00, 127MB/s]
model-00022-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:19<00:00, 126MB/s]
model-00023-of-00024.safetensors: 100%|████████████████████████████████████████████████████████████████████████████████████████████| 10.0G/10.0G [01:18<00:00, 127MB/s]
(Worker_TP4_EP4 pid=2082) INFO 09-24 20:50:44 [weight_utils.py:369] Time spent downloading weights for Qwen/Qwen3-235B-A22B-Instruct-2507-FP8: 272.079211 seconds7MB/s]
model.safetensors.index.json: 6.99MB [00:00, 210MB/s]████████████████████████████████████████████████████████████████████████████▏ | 9.80G/10.0G [01:18<00:00, 319MB/s]
Loading safetensors checkpoint shards:   0% Completed | 0/24 [00:00<?, ?it/s]█████████████████████████████████████████████████████▍| 9.93G/10.0G [01:18<00:00, 447MB/s]
Loading safetensors checkpoint shards:   4% Completed | 1/24 [00:00<00:12,  1.88it/s]██████████████████████████████████████████████| 10.0G/10.0G [01:19<00:00, 434MB/s]
Loading safetensors checkpoint shards:   8% Completed | 2/24 [00:01<00:12,  1.74it/s]
Loading safetensors checkpoint shards:  12% Completed | 3/24 [00:01<00:12,  1.71it/s]
Loading safetensors checkpoint shards:  17% Completed | 4/24 [00:02<00:11,  1.69it/s]
Loading safetensors checkpoint shards:  21% Completed | 5/24 [00:02<00:11,  1.71it/s]
Loading safetensors checkpoint shards:  25% Completed | 6/24 [00:03<00:10,  1.77it/s]
Loading safetensors checkpoint shards:  29% Completed | 7/24 [00:03<00:09,  1.80it/s]
Loading safetensors checkpoint shards:  33% Completed | 8/24 [00:04<00:08,  1.82it/s]
Loading safetensors checkpoint shards:  38% Completed | 9/24 [00:05<00:08,  1.84it/s]
Loading safetensors checkpoint shards:  42% Completed | 10/24 [00:05<00:07,  1.86it/s]
Loading safetensors checkpoint shards:  46% Completed | 11/24 [00:06<00:06,  1.87it/s]
Loading safetensors checkpoint shards:  50% Completed | 12/24 [00:06<00:06,  1.86it/s]
Loading safetensors checkpoint shards:  54% Completed | 13/24 [00:07<00:05,  1.86it/s]
Loading safetensors checkpoint shards:  58% Completed | 14/24 [00:07<00:05,  1.86it/s]
Loading safetensors checkpoint shards:  62% Completed | 15/24 [00:08<00:04,  1.86it/s]
Loading safetensors checkpoint shards:  67% Completed | 16/24 [00:08<00:04,  1.86it/s]
Loading safetensors checkpoint shards:  71% Completed | 17/24 [00:09<00:03,  1.85it/s]
Loading safetensors checkpoint shards:  75% Completed | 18/24 [00:09<00:02,  2.08it/s]
Loading safetensors checkpoint shards:  79% Completed | 19/24 [00:10<00:02,  2.03it/s]
Loading safetensors checkpoint shards:  83% Completed | 20/24 [00:10<00:02,  1.98it/s]
Loading safetensors checkpoint shards:  88% Completed | 21/24 [00:11<00:01,  1.95it/s]
(Worker_TP1_EP1 pid=2079) INFO 09-24 20:50:57 [default_loader.py:268] Loading weights took 12.18 seconds
Loading safetensors checkpoint shards:  92% Completed | 22/24 [00:11<00:01,  1.93it/s]
(Worker_TP6_EP6 pid=2084) INFO 09-24 20:50:58 [default_loader.py:268] Loading weights took 12.36 seconds
(Worker_TP1_EP1 pid=2079) INFO 09-24 20:50:58 [gpu_model_runner.py:2392] Model loading took 27.7183 GiB and 286.020245 seconds
(Worker_TP4_EP4 pid=2082) INFO 09-24 20:50:58 [default_loader.py:268] Loading weights took 13.40 seconds
Loading safetensors checkpoint shards:  96% Completed | 23/24 [00:12<00:00,  1.90it/s]
(Worker_TP6_EP6 pid=2084) INFO 09-24 20:50:58 [gpu_model_runner.py:2392] Model loading took 27.7183 GiB and 286.546282 seconds
(Worker_TP2_EP2 pid=2080) INFO 09-24 20:50:58 [default_loader.py:268] Loading weights took 12.00 seconds
(Worker_TP4_EP4 pid=2082) INFO 09-24 20:50:58 [gpu_model_runner.py:2392] Model loading took 27.7183 GiB and 286.803597 seconds
Loading safetensors checkpoint shards: 100% Completed | 24/24 [00:12<00:00,  1.91it/s]
Loading safetensors checkpoint shards: 100% Completed | 24/24 [00:12<00:00,  1.87it/s]
(Worker_TP0_EP0 pid=2078) 
(Worker_TP5_EP5 pid=2083) INFO 09-24 20:50:58 [default_loader.py:268] Loading weights took 13.65 seconds
(Worker_TP0_EP0 pid=2078) INFO 09-24 20:50:58 [default_loader.py:268] Loading weights took 12.89 seconds
(Worker_TP3_EP3 pid=2081) INFO 09-24 20:50:58 [default_loader.py:268] Loading weights took 12.34 seconds
(Worker_TP2_EP2 pid=2080) INFO 09-24 20:50:59 [gpu_model_runner.py:2392] Model loading took 27.7183 GiB and 287.251049 seconds
(Worker_TP0_EP0 pid=2078) INFO 09-24 20:50:59 [gpu_model_runner.py:2392] Model loading took 27.7183 GiB and 287.369035 seconds
(Worker_TP3_EP3 pid=2081) INFO 09-24 20:50:59 [gpu_model_runner.py:2392] Model loading took 27.7183 GiB and 287.323476 seconds
(Worker_TP5_EP5 pid=2083) INFO 09-24 20:50:59 [gpu_model_runner.py:2392] Model loading took 27.7183 GiB and 287.256867 seconds
(Worker_TP7_EP7 pid=2085) INFO 09-24 20:50:59 [default_loader.py:268] Loading weights took 13.32 seconds
(Worker_TP7_EP7 pid=2085) INFO 09-24 20:50:59 [gpu_model_runner.py:2392] Model loading took 27.7183 GiB and 287.995398 seconds
(Worker_TP3_EP3 pid=2081) INFO 09-24 20:51:19 [backends.py:539] Using cache directory: /root/.cache/vllm/torch_compile_cache/35eda47464/rank_3_0/backbone for vLLM's torch.compile
(Worker_TP3_EP3 pid=2081) INFO 09-24 20:51:19 [backends.py:550] Dynamo bytecode transform time: 19.63 s
(Worker_TP2_EP2 pid=2080) INFO 09-24 20:51:20 [backends.py:539] Using cache directory: /root/.cache/vllm/torch_compile_cache/35eda47464/rank_2_0/backbone for vLLM's torch.compile
(Worker_TP2_EP2 pid=2080) INFO 09-24 20:51:20 [backends.py:550] Dynamo bytecode transform time: 19.91 s
(Worker_TP0_EP0 pid=2078) INFO 09-24 20:51:20 [backends.py:539] Using cache directory: /root/.cache/vllm/torch_compile_cache/35eda47464/rank_0_0/backbone for vLLM's torch.compile
(Worker_TP0_EP0 pid=2078) INFO 09-24 20:51:20 [backends.py:550] Dynamo bytecode transform time: 19.95 s
(Worker_TP6_EP6 pid=2084) INFO 09-24 20:51:20 [backends.py:539] Using cache directory: /root/.cache/vllm/torch_compile_cache/35eda47464/rank_6_0/backbone for vLLM's torch.compile
(Worker_TP6_EP6 pid=2084) INFO 09-24 20:51:20 [backends.py:550] Dynamo bytecode transform time: 20.27 s
(Worker_TP1_EP1 pid=2079) INFO 09-24 20:51:21 [backends.py:539] Using cache directory: /root/.cache/vllm/torch_compile_cache/35eda47464/rank_1_0/backbone for vLLM's torch.compile
(Worker_TP1_EP1 pid=2079) INFO 09-24 20:51:21 [backends.py:550] Dynamo bytecode transform time: 21.06 s
(Worker_TP4_EP4 pid=2082) INFO 09-24 20:51:21 [backends.py:539] Using cache directory: /root/.cache/vllm/torch_compile_cache/35eda47464/rank_4_0/backbone for vLLM's torch.compile
(Worker_TP4_EP4 pid=2082) INFO 09-24 20:51:21 [backends.py:550] Dynamo bytecode transform time: 21.09 s
(Worker_TP5_EP5 pid=2083) INFO 09-24 20:51:21 [backends.py:539] Using cache directory: /root/.cache/vllm/torch_compile_cache/35eda47464/rank_5_0/backbone for vLLM's torch.compile
(Worker_TP5_EP5 pid=2083) INFO 09-24 20:51:21 [backends.py:550] Dynamo bytecode transform time: 21.15 s
(Worker_TP7_EP7 pid=2085) INFO 09-24 20:51:21 [backends.py:539] Using cache directory: /root/.cache/vllm/torch_compile_cache/35eda47464/rank_7_0/backbone for vLLM's torch.compile
(Worker_TP7_EP7 pid=2085) INFO 09-24 20:51:21 [backends.py:550] Dynamo bytecode transform time: 21.47 s
(Worker_TP2_EP2 pid=2080) INFO 09-24 20:51:27 [backends.py:194] Cache the graph for dynamic shape for later use
(Worker_TP3_EP3 pid=2081) INFO 09-24 20:51:27 [backends.py:194] Cache the graph for dynamic shape for later use
(Worker_TP6_EP6 pid=2084) INFO 09-24 20:51:27 [backends.py:194] Cache the graph for dynamic shape for later use
(Worker_TP0_EP0 pid=2078) INFO 09-24 20:51:27 [backends.py:194] Cache the graph for dynamic shape for later use
(Worker_TP1_EP1 pid=2079) INFO 09-24 20:51:28 [backends.py:194] Cache the graph for dynamic shape for later use
(Worker_TP4_EP4 pid=2082) INFO 09-24 20:51:28 [backends.py:194] Cache the graph for dynamic shape for later use
(Worker_TP5_EP5 pid=2083) INFO 09-24 20:51:29 [backends.py:194] Cache the graph for dynamic shape for later use
(Worker_TP7_EP7 pid=2085) INFO 09-24 20:51:30 [backends.py:194] Cache the graph for dynamic shape for later use
(Worker_TP1_EP1 pid=2079) INFO 09-24 20:53:19 [backends.py:215] Compiling a graph for dynamic shape takes 117.20 s
(Worker_TP6_EP6 pid=2084) INFO 09-24 20:53:21 [backends.py:215] Compiling a graph for dynamic shape takes 120.22 s
(Worker_TP2_EP2 pid=2080) INFO 09-24 20:53:23 [backends.py:215] Compiling a graph for dynamic shape takes 122.29 s
(Worker_TP0_EP0 pid=2078) INFO 09-24 20:53:23 [backends.py:215] Compiling a graph for dynamic shape takes 122.30 s
(Worker_TP4_EP4 pid=2082) INFO 09-24 20:53:26 [backends.py:215] Compiling a graph for dynamic shape takes 123.65 s
(Worker_TP3_EP3 pid=2081) INFO 09-24 20:53:26 [backends.py:215] Compiling a graph for dynamic shape takes 125.34 s
(Worker_TP7_EP7 pid=2085) INFO 09-24 20:53:27 [backends.py:215] Compiling a graph for dynamic shape takes 124.90 s
(Worker_TP5_EP5 pid=2083) INFO 09-24 20:53:29 [backends.py:215] Compiling a graph for dynamic shape takes 126.49 s
(Worker_TP5_EP5 pid=2083) WARNING 09-24 20:53:32 [fp8_utils.py:581] Using default W8A8 Block FP8 kernel config. Performance might be sub-optimal! Config file not found at /workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/quantization/utils/configs/N=1280,K=4096,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json
(Worker_TP3_EP3 pid=2081) WARNING 09-24 20:53:32 [fp8_utils.py:581] Using default W8A8 Block FP8 kernel config. Performance might be sub-optimal! Config file not found at /workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/quantization/utils/configs/N=1280,K=4096,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json
(Worker_TP6_EP6 pid=2084) WARNING 09-24 20:53:32 [fp8_utils.py:581] Using default W8A8 Block FP8 kernel config. Performance might be sub-optimal! Config file not found at /workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/quantization/utils/configs/N=1280,K=4096,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json
(Worker_TP7_EP7 pid=2085) WARNING 09-24 20:53:32 [fp8_utils.py:581] Using default W8A8 Block FP8 kernel config. Performance might be sub-optimal! Config file not found at /workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/quantization/utils/configs/N=1280,K=4096,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json
(Worker_TP2_EP2 pid=2080) WARNING 09-24 20:53:32 [fp8_utils.py:581] Using default W8A8 Block FP8 kernel config. Performance might be sub-optimal! Config file not found at /workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/quantization/utils/configs/N=1280,K=4096,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json
(Worker_TP4_EP4 pid=2082) WARNING 09-24 20:53:32 [fp8_utils.py:581] Using default W8A8 Block FP8 kernel config. Performance might be sub-optimal! Config file not found at /workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/quantization/utils/configs/N=1280,K=4096,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json
(Worker_TP1_EP1 pid=2079) WARNING 09-24 20:53:32 [fp8_utils.py:581] Using default W8A8 Block FP8 kernel config. Performance might be sub-optimal! Config file not found at /workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/quantization/utils/configs/N=1280,K=4096,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json
(Worker_TP0_EP0 pid=2078) WARNING 09-24 20:53:32 [fp8_utils.py:581] Using default W8A8 Block FP8 kernel config. Performance might be sub-optimal! Config file not found at /workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/quantization/utils/configs/N=1280,K=4096,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json
(Worker_TP6_EP6 pid=2084) WARNING 09-24 20:53:33 [fp8_utils.py:581] Using default W8A8 Block FP8 kernel config. Performance might be sub-optimal! Config file not found at /workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/quantization/utils/configs/N=4096,K=1024,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json
(Worker_TP2_EP2 pid=2080) WARNING 09-24 20:53:33 [fp8_utils.py:581] Using default W8A8 Block FP8 kernel config. Performance might be sub-optimal! Config file not found at /workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/quantization/utils/configs/N=4096,K=1024,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json
(Worker_TP5_EP5 pid=2083) WARNING 09-24 20:53:33 [fp8_utils.py:581] Using default W8A8 Block FP8 kernel config. Performance might be sub-optimal! Config file not found at /workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/quantization/utils/configs/N=4096,K=1024,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json
(Worker_TP4_EP4 pid=2082) WARNING 09-24 20:53:33 [fp8_utils.py:581] Using default W8A8 Block FP8 kernel config. Performance might be sub-optimal! Config file not found at /workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/quantization/utils/configs/N=4096,K=1024,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json
(Worker_TP7_EP7 pid=2085) WARNING 09-24 20:53:33 [fp8_utils.py:581] Using default W8A8 Block FP8 kernel config. Performance might be sub-optimal! Config file not found at /workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/quantization/utils/configs/N=4096,K=1024,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json
(Worker_TP0_EP0 pid=2078) WARNING 09-24 20:53:33 [fp8_utils.py:581] Using default W8A8 Block FP8 kernel config. Performance might be sub-optimal! Config file not found at /workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/quantization/utils/configs/N=4096,K=1024,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json
(Worker_TP3_EP3 pid=2081) WARNING 09-24 20:53:33 [fp8_utils.py:581] Using default W8A8 Block FP8 kernel config. Performance might be sub-optimal! Config file not found at /workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/quantization/utils/configs/N=4096,K=1024,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json
(Worker_TP1_EP1 pid=2079) WARNING 09-24 20:53:33 [fp8_utils.py:581] Using default W8A8 Block FP8 kernel config. Performance might be sub-optimal! Config file not found at /workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/quantization/utils/configs/N=4096,K=1024,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json
(Worker_TP2_EP2 pid=2080) (Worker_TP6_EP6 pid=2084) WARNING 09-24 20:53:34 [fused_moe.py:727] Using default MoE config. Performance might be sub-optimal! Config file not found at ['/workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/fused_moe/configs/E=16,N=1536,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json']
WARNING 09-24 20:53:34 [fused_moe.py:727] Using default MoE config. Performance might be sub-optimal! Config file not found at ['/workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/fused_moe/configs/E=16,N=1536,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json']
(Worker_TP7_EP7 pid=2085) WARNING 09-24 20:53:34 [fused_moe.py:727] Using default MoE config. Performance might be sub-optimal! Config file not found at ['/workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/fused_moe/configs/E=16,N=1536,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json']
(Worker_TP4_EP4 pid=2082) WARNING 09-24 20:53:34 [fused_moe.py:727] Using default MoE config. Performance might be sub-optimal! Config file not found at ['/workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/fused_moe/configs/E=16,N=1536,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json']
(Worker_TP3_EP3 pid=2081) (Worker_TP5_EP5 pid=2083) WARNING 09-24 20:53:34 [fused_moe.py:727] Using default MoE config. Performance might be sub-optimal! Config file not found at ['/workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/fused_moe/configs/E=16,N=1536,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json']
WARNING 09-24 20:53:34 [fused_moe.py:727] Using default MoE config. Performance might be sub-optimal! Config file not found at ['/workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/fused_moe/configs/E=16,N=1536,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json']
(Worker_TP0_EP0 pid=2078) WARNING 09-24 20:53:34 [fused_moe.py:727] Using default MoE config. Performance might be sub-optimal! Config file not found at ['/workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/fused_moe/configs/E=16,N=1536,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json']
(Worker_TP1_EP1 pid=2079) WARNING 09-24 20:53:34 [fused_moe.py:727] Using default MoE config. Performance might be sub-optimal! Config file not found at ['/workspace/.venv/lib/python3.12/site-packages/vllm/model_executor/layers/fused_moe/configs/E=16,N=1536,device_name=NVIDIA_L40S,dtype=fp8_w8a8,block_shape=[128,128].json']
(Worker_TP5_EP5 pid=2083) INFO 09-24 20:53:37 [monitor.py:34] torch.compile takes 147.63 s in total
(Worker_TP4_EP4 pid=2082) INFO 09-24 20:53:37 [monitor.py:34] torch.compile takes 144.74 s in total
(Worker_TP3_EP3 pid=2081) (Worker_TP6_EP6 pid=2084) INFO 09-24 20:53:37 [monitor.py:34] torch.compile takes 144.97 s in total
INFO 09-24 20:53:37 [monitor.py:34] torch.compile takes 140.48 s in total
(Worker_TP7_EP7 pid=2085) INFO 09-24 20:53:37 [monitor.py:34] torch.compile takes 146.38 s in total
(Worker_TP2_EP2 pid=2080) INFO 09-24 20:53:37 [monitor.py:34] torch.compile takes 142.19 s in total
(Worker_TP1_EP1 pid=2079) INFO 09-24 20:53:37 [monitor.py:34] torch.compile takes 138.26 s in total
(Worker_TP0_EP0 pid=2078) INFO 09-24 20:53:37 [monitor.py:34] torch.compile takes 142.25 s in total
(Worker_TP6_EP6 pid=2084) INFO 09-24 20:53:40 [gpu_worker.py:298] Available KV cache memory: 10.64 GiB
(Worker_TP2_EP2 pid=2080) INFO 09-24 20:53:40 [gpu_worker.py:298] Available KV cache memory: 10.64 GiB
(Worker_TP7_EP7 pid=2085) INFO 09-24 20:53:40 [gpu_worker.py:298] Available KV cache memory: 10.65 GiB
(Worker_TP0_EP0 pid=2078) INFO 09-24 20:53:40 [gpu_worker.py:298] Available KV cache memory: 10.68 GiB
(Worker_TP4_EP4 pid=2082) INFO 09-24 20:53:40 [gpu_worker.py:298] Available KV cache memory: 10.68 GiB
(Worker_TP5_EP5 pid=2083) INFO 09-24 20:53:40 [gpu_worker.py:298] Available KV cache memory: 10.64 GiB
(Worker_TP1_EP1 pid=2079) INFO 09-24 20:53:41 [gpu_worker.py:298] Available KV cache memory: 10.64 GiB
(Worker_TP3_EP3 pid=2081) INFO 09-24 20:53:41 [gpu_worker.py:298] Available KV cache memory: 10.65 GiB
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:864] GPU KV cache size: 238,208 tokens
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 7.27x
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:864] GPU KV cache size: 237,392 tokens
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 7.24x
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:864] GPU KV cache size: 237,344 tokens
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 7.24x
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:864] GPU KV cache size: 237,520 tokens
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 7.25x
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:864] GPU KV cache size: 238,256 tokens
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 7.27x
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:864] GPU KV cache size: 237,344 tokens
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 7.24x
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:864] GPU KV cache size: 237,392 tokens
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 7.24x
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:864] GPU KV cache size: 237,520 tokens
(EngineCore_DP0 pid=1944) INFO 09-24 20:53:41 [kv_cache_utils.py:868] Maximum concurrency for 32,768 tokens per request: 7.25x
Capturing CUDA graphs (mixed prefill-decode, PIECEWISE): 100%|█████████████████████████████████████████████████████████████████████████| 67/67 [00:52<00:00,  1.28it/s]
(Worker_TP2_EP2 pid=2080) INFO 09-24 20:54:35 [gpu_model_runner.py:3118] Graph capturing finished in 53 secs, took 3.45 GiB
(Worker_TP2_EP2 pid=2080) INFO 09-24 20:54:35 [gpu_worker.py:391] Free memory on device (43.93/44.42 GiB) on startup. Desired GPU memory utilization is (0.9, 39.98 GiB). Actual usage is 27.72 GiB for weight, 1.4 GiB for peak activation, 0.21 GiB for non-torch memory, and 3.45 GiB for CUDAGraph memory. Replace gpu_memory_utilization config with `--kv-cache-memory=7564378828` to fit into requested memory, or `--kv-cache-memory=11809093120` to fully utilize gpu memory. Current kv cache memory in use is 11423138508 bytes.
(Worker_TP7_EP7 pid=2085) INFO 09-24 20:54:36 [gpu_model_runner.py:3118] Graph capturing finished in 53 secs, took 3.45 GiB
(Worker_TP7_EP7 pid=2085) INFO 09-24 20:54:36 [gpu_worker.py:391] Free memory on device (43.93/44.42 GiB) on startup. Desired GPU memory utilization is (0.9, 39.98 GiB). Actual usage is 27.72 GiB for weight, 1.4 GiB for peak activation, 0.21 GiB for non-torch memory, and 3.45 GiB for CUDAGraph memory. Replace gpu_memory_utilization config with `--kv-cache-memory=7572767436` to fit into requested memory, or `--kv-cache-memory=11817481728` to fully utilize gpu memory. Current kv cache memory in use is 11431527116 bytes.
(Worker_TP0_EP0 pid=2078) INFO 09-24 20:54:36 [gpu_model_runner.py:3118] Graph capturing finished in 53 secs, took 3.45 GiB
(Worker_TP0_EP0 pid=2078) INFO 09-24 20:54:36 [gpu_worker.py:391] Free memory on device (43.93/44.42 GiB) on startup. Desired GPU memory utilization is (0.9, 39.98 GiB). Actual usage is 27.72 GiB for weight, 1.4 GiB for peak activation, 0.18 GiB for non-torch memory, and 3.45 GiB for CUDAGraph memory. Replace gpu_memory_utilization config with `--kv-cache-memory=7606321868` to fit into requested memory, or `--kv-cache-memory=11851036160` to fully utilize gpu memory. Current kv cache memory in use is 11465081548 bytes.
(Worker_TP6_EP6 pid=2084) INFO 09-24 20:54:36 [gpu_model_runner.py:3118] Graph capturing finished in 53 secs, took 3.45 GiB
(Worker_TP6_EP6 pid=2084) INFO 09-24 20:54:36 [gpu_worker.py:391] Free memory on device (43.93/44.42 GiB) on startup. Desired GPU memory utilization is (0.9, 39.98 GiB). Actual usage is 27.72 GiB for weight, 1.4 GiB for peak activation, 0.21 GiB for non-torch memory, and 3.45 GiB for CUDAGraph memory. Replace gpu_memory_utilization config with `--kv-cache-memory=7564378828` to fit into requested memory, or `--kv-cache-memory=11809093120` to fully utilize gpu memory. Current kv cache memory in use is 11425235660 bytes.
(Worker_TP4_EP4 pid=2082) INFO 09-24 20:54:36 [gpu_model_runner.py:3118] Graph capturing finished in 53 secs, took 3.45 GiB
(Worker_TP4_EP4 pid=2082) INFO 09-24 20:54:36 [gpu_worker.py:391] Free memory on device (43.93/44.42 GiB) on startup. Desired GPU memory utilization is (0.9, 39.98 GiB). Actual usage is 27.72 GiB for weight, 1.4 GiB for peak activation, 0.17 GiB for non-torch memory, and 3.45 GiB for CUDAGraph memory. Replace gpu_memory_utilization config with `--kv-cache-memory=7606321868` to fit into requested memory, or `--kv-cache-memory=11851036160` to fully utilize gpu memory. Current kv cache memory in use is 11467178700 bytes.
(Worker_TP5_EP5 pid=2083) INFO 09-24 20:54:36 [gpu_model_runner.py:3118] Graph capturing finished in 54 secs, took 3.45 GiB
(Worker_TP5_EP5 pid=2083) INFO 09-24 20:54:36 [gpu_worker.py:391] Free memory on device (43.93/44.42 GiB) on startup. Desired GPU memory utilization is (0.9, 39.98 GiB). Actual usage is 27.72 GiB for weight, 1.4 GiB for peak activation, 0.21 GiB for non-torch memory, and 3.45 GiB for CUDAGraph memory. Replace gpu_memory_utilization config with `--kv-cache-memory=7564378828` to fit into requested memory, or `--kv-cache-memory=11809093120` to fully utilize gpu memory. Current kv cache memory in use is 11423138508 bytes.
(Worker_TP3_EP3 pid=2081) INFO 09-24 20:54:36 [gpu_model_runner.py:3118] Graph capturing finished in 54 secs, took 3.45 GiB
(Worker_TP3_EP3 pid=2081) INFO 09-24 20:54:36 [gpu_worker.py:391] Free memory on device (43.93/44.42 GiB) on startup. Desired GPU memory utilization is (0.9, 39.98 GiB). Actual usage is 27.72 GiB for weight, 1.4 GiB for peak activation, 0.21 GiB for non-torch memory, and 3.45 GiB for CUDAGraph memory. Replace gpu_memory_utilization config with `--kv-cache-memory=7572767436` to fit into requested memory, or `--kv-cache-memory=11817481728` to fully utilize gpu memory. Current kv cache memory in use is 11431527116 bytes.
(Worker_TP1_EP1 pid=2079) INFO 09-24 20:54:36 [gpu_model_runner.py:3118] Graph capturing finished in 54 secs, took 3.45 GiB
(Worker_TP1_EP1 pid=2079) INFO 09-24 20:54:36 [gpu_worker.py:391] Free memory on device (43.93/44.42 GiB) on startup. Desired GPU memory utilization is (0.9, 39.98 GiB). Actual usage is 27.72 GiB for weight, 1.4 GiB for peak activation, 0.21 GiB for non-torch memory, and 3.45 GiB for CUDAGraph memory. Replace gpu_memory_utilization config with `--kv-cache-memory=7564378828` to fit into requested memory, or `--kv-cache-memory=11809093120` to fully utilize gpu memory. Current kv cache memory in use is 11425235660 bytes.
(EngineCore_DP0 pid=1944) INFO 09-24 20:54:36 [core.py:218] init engine (profile, create kv cache, warmup model) took 216.57 seconds
(APIServer pid=1624) INFO 09-24 20:54:37 [loggers.py:142] Engine 000: vllm cache_config_info with initialization after num_gpu_blocks is: 14834
(APIServer pid=1624) INFO 09-24 20:54:37 [async_llm.py:180] Torch profiler disabled. AsyncLLM CPU traces will not be collected.
(APIServer pid=1624) INFO 09-24 20:54:37 [api_server.py:1692] Supported_tasks: ['generate']
(APIServer pid=1624) WARNING 09-24 20:54:37 [__init__.py:1695] Default sampling parameters have been overridden by the model's Hugging Face generation config recommended from the model creator. If this is not intended, please relaunch vLLM instance with `--generation-config vllm`.
(APIServer pid=1624) INFO 09-24 20:54:37 [serving_responses.py:130] Using default chat sampling params from model: {'temperature': 0.7, 'top_k': 20, 'top_p': 0.8}
(APIServer pid=1624) INFO 09-24 20:54:37 [serving_chat.py:137] Using default chat sampling params from model: {'temperature': 0.7, 'top_k': 20, 'top_p': 0.8}
(APIServer pid=1624) INFO 09-24 20:54:38 [serving_completion.py:76] Using default completion sampling params from model: {'temperature': 0.7, 'top_k': 20, 'top_p': 0.8}
(APIServer pid=1624) INFO 09-24 20:54:38 [api_server.py:1971] Starting vLLM API server 0 on http://0.0.0.0:8000
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:36] Available routes are:
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /openapi.json, Methods: GET, HEAD
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /docs, Methods: GET, HEAD
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /docs/oauth2-redirect, Methods: GET, HEAD
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /redoc, Methods: GET, HEAD
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /health, Methods: GET
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /load, Methods: GET
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /ping, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /ping, Methods: GET
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /tokenize, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /detokenize, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /v1/models, Methods: GET
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /version, Methods: GET
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /v1/responses, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /v1/responses/{response_id}, Methods: GET
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /v1/responses/{response_id}/cancel, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /v1/chat/completions, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /v1/completions, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /v1/embeddings, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /pooling, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /classify, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /score, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /v1/score, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /v1/audio/transcriptions, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /v1/audio/translations, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /rerank, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /v1/rerank, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /v2/rerank, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /scale_elastic_ep, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /is_scaling_elastic_ep, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /invocations, Methods: POST
(APIServer pid=1624) INFO 09-24 20:54:38 [launcher.py:44] Route: /metrics, Methods: GET
(APIServer pid=1624) INFO:     Started server process [1624]
(APIServer pid=1624) INFO:     Waiting for application startup.
(APIServer pid=1624) INFO:     Application startup complete.
(APIServer pid=1624) INFO 09-24 20:55:03 [chat_utils.py:538] Detected the chat template content format to be 'string'. You can set `--chat-template-content-format` to override this.
(APIServer pid=1624) INFO:     127.0.0.1:52906 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO 09-24 20:55:08 [loggers.py:123] Engine 000: Avg prompt throughput: 2.6 tokens/s, Avg generation throughput: 19.3 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.1%, Prefix cache hit rate: 0.0%
(APIServer pid=1624) INFO 09-24 20:55:18 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 40.0 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.3%, Prefix cache hit rate: 0.0%
(APIServer pid=1624) INFO 09-24 20:55:28 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 39.0 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.4%, Prefix cache hit rate: 0.0%
(APIServer pid=1624) INFO 09-24 20:55:38 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 39.6 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.6%, Prefix cache hit rate: 0.0%
(APIServer pid=1624) INFO 09-24 20:55:48 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 40.1 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.8%, Prefix cache hit rate: 0.0%
(APIServer pid=1624) INFO 09-24 20:55:58 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 38.9 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.9%, Prefix cache hit rate: 0.0%
(APIServer pid=1624) INFO 09-24 20:56:08 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 23.6 tokens/s, Running: 0 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.0%, Prefix cache hit rate: 0.0%
(APIServer pid=1624) INFO 09-24 20:56:18 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 0.0 tokens/s, Running: 0 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.0%, Prefix cache hit rate: 0.0%
(APIServer pid=1624) INFO:     127.0.0.1:48844 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO 09-24 20:56:28 [loggers.py:123] Engine 000: Avg prompt throughput: 2.6 tokens/s, Avg generation throughput: 16.7 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.1%, Prefix cache hit rate: 30.8%
(APIServer pid=1624) INFO 09-24 20:56:38 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 39.3 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.2%, Prefix cache hit rate: 30.8%
(APIServer pid=1624) INFO 09-24 20:56:48 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 39.3 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.4%, Prefix cache hit rate: 30.8%
(APIServer pid=1624) INFO 09-24 20:56:58 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 39.3 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.6%, Prefix cache hit rate: 30.8%
(APIServer pid=1624) INFO 09-24 20:57:08 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 39.3 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.7%, Prefix cache hit rate: 30.8%
(APIServer pid=1624) INFO 09-24 20:57:18 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 32.3 tokens/s, Running: 0 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.0%, Prefix cache hit rate: 30.8%
(APIServer pid=1624) INFO 09-24 20:57:28 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 0.0 tokens/s, Running: 0 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.0%, Prefix cache hit rate: 30.8%
(APIServer pid=1624) INFO:     127.0.0.1:52618 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52624 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52626 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52642 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52658 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52672 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52676 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52688 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO 09-24 20:57:38 [loggers.py:123] Engine 000: Avg prompt throughput: 20.8 tokens/s, Avg generation throughput: 19.3 tokens/s, Running: 8 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.2%, Prefix cache hit rate: 55.4%
(APIServer pid=1624) INFO 09-24 20:57:48 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 192.0 tokens/s, Running: 8 reqs, Waiting: 0 reqs, GPU KV cache usage: 1.0%, Prefix cache hit rate: 55.4%
(APIServer pid=1624) INFO 09-24 20:57:58 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 186.4 tokens/s, Running: 8 reqs, Waiting: 0 reqs, GPU KV cache usage: 1.7%, Prefix cache hit rate: 55.4%
(APIServer pid=1624) INFO 09-24 20:58:08 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 184.0 tokens/s, Running: 8 reqs, Waiting: 0 reqs, GPU KV cache usage: 2.5%, Prefix cache hit rate: 55.4%
(APIServer pid=1624) INFO 09-24 20:58:18 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 185.6 tokens/s, Running: 8 reqs, Waiting: 0 reqs, GPU KV cache usage: 3.3%, Prefix cache hit rate: 55.4%
(APIServer pid=1624) INFO 09-24 20:58:28 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 184.8 tokens/s, Running: 8 reqs, Waiting: 0 reqs, GPU KV cache usage: 4.1%, Prefix cache hit rate: 55.4%
(APIServer pid=1624) INFO 09-24 20:58:38 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 185.6 tokens/s, Running: 8 reqs, Waiting: 0 reqs, GPU KV cache usage: 4.9%, Prefix cache hit rate: 55.4%
(APIServer pid=1624) INFO 09-24 20:58:48 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 184.0 tokens/s, Running: 8 reqs, Waiting: 0 reqs, GPU KV cache usage: 5.6%, Prefix cache hit rate: 55.4%
(APIServer pid=1624) INFO 09-24 20:58:58 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 181.9 tokens/s, Running: 7 reqs, Waiting: 0 reqs, GPU KV cache usage: 5.6%, Prefix cache hit rate: 55.4%
(APIServer pid=1624) INFO 09-24 20:59:08 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 113.5 tokens/s, Running: 2 reqs, Waiting: 0 reqs, GPU KV cache usage: 1.8%, Prefix cache hit rate: 55.4%
(APIServer pid=1624) INFO 09-24 20:59:18 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 9.2 tokens/s, Running: 0 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.0%, Prefix cache hit rate: 55.4%
(APIServer pid=1624) INFO:     127.0.0.1:39648 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO 09-24 20:59:28 [loggers.py:123] Engine 000: Avg prompt throughput: 2.6 tokens/s, Avg generation throughput: 3.4 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.0%, Prefix cache hit rate: 55.9%
(APIServer pid=1624) INFO 09-24 20:59:38 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 39.0 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.2%, Prefix cache hit rate: 55.9%
(APIServer pid=1624) INFO 09-24 20:59:48 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 39.7 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.4%, Prefix cache hit rate: 55.9%
(APIServer pid=1624) INFO 09-24 20:59:58 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 38.7 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.5%, Prefix cache hit rate: 55.9%
(APIServer pid=1624) INFO 09-24 21:00:08 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 38.5 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.7%, Prefix cache hit rate: 55.9%
(APIServer pid=1624) INFO 09-24 21:00:18 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 39.4 tokens/s, Running: 1 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.8%, Prefix cache hit rate: 55.9%
(APIServer pid=1624) INFO 09-24 21:00:28 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 25.3 tokens/s, Running: 0 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.0%, Prefix cache hit rate: 55.9%
(APIServer pid=1624) INFO 09-24 21:00:38 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 0.0 tokens/s, Running: 0 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.0%, Prefix cache hit rate: 55.9%
(APIServer pid=1624) INFO:     127.0.0.1:51860 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:51862 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:51866 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:51874 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:51882 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:51898 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:51902 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:51916 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:51930 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:51932 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:51946 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:51962 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:51972 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:51970 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:51986 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:51992 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:51998 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52006 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52010 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52038 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52024 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52018 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52044 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52048 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52062 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52072 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52074 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52088 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52098 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52116 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52106 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:52124 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO 09-24 21:00:48 [loggers.py:123] Engine 000: Avg prompt throughput: 83.2 tokens/s, Avg generation throughput: 328.2 tokens/s, Running: 32 reqs, Waiting: 0 reqs, GPU KV cache usage: 1.5%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:00:58 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 393.4 tokens/s, Running: 32 reqs, Waiting: 0 reqs, GPU KV cache usage: 3.2%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:01:08 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 387.2 tokens/s, Running: 32 reqs, Waiting: 0 reqs, GPU KV cache usage: 5.0%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:01:18 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 393.6 tokens/s, Running: 32 reqs, Waiting: 0 reqs, GPU KV cache usage: 6.5%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:01:28 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 387.0 tokens/s, Running: 32 reqs, Waiting: 0 reqs, GPU KV cache usage: 8.2%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:01:38 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 380.8 tokens/s, Running: 32 reqs, Waiting: 0 reqs, GPU KV cache usage: 9.7%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:01:48 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 387.0 tokens/s, Running: 32 reqs, Waiting: 0 reqs, GPU KV cache usage: 11.4%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:01:58 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 387.0 tokens/s, Running: 32 reqs, Waiting: 0 reqs, GPU KV cache usage: 13.1%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:02:08 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 387.2 tokens/s, Running: 32 reqs, Waiting: 0 reqs, GPU KV cache usage: 14.7%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:02:18 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 387.2 tokens/s, Running: 32 reqs, Waiting: 0 reqs, GPU KV cache usage: 16.4%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:02:28 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 384.0 tokens/s, Running: 32 reqs, Waiting: 0 reqs, GPU KV cache usage: 17.9%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:02:38 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 387.0 tokens/s, Running: 32 reqs, Waiting: 0 reqs, GPU KV cache usage: 19.6%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:02:48 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 384.0 tokens/s, Running: 32 reqs, Waiting: 0 reqs, GPU KV cache usage: 21.1%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:02:58 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 380.8 tokens/s, Running: 32 reqs, Waiting: 0 reqs, GPU KV cache usage: 22.9%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:03:08 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 383.8 tokens/s, Running: 32 reqs, Waiting: 0 reqs, GPU KV cache usage: 24.4%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:03:18 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 356.8 tokens/s, Running: 29 reqs, Waiting: 0 reqs, GPU KV cache usage: 23.5%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:03:28 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 280.8 tokens/s, Running: 17 reqs, Waiting: 0 reqs, GPU KV cache usage: 14.8%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:03:38 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 182.1 tokens/s, Running: 4 reqs, Waiting: 0 reqs, GPU KV cache usage: 3.8%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:03:48 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 43.9 tokens/s, Running: 0 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.0%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO 09-24 21:03:58 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 0.0 tokens/s, Running: 0 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.0%, Prefix cache hit rate: 60.1%
(APIServer pid=1624) INFO:     127.0.0.1:50212 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:50214 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:50220 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO:     127.0.0.1:50234 - "POST /v1/chat/completions HTTP/1.1" 200 OK
(APIServer pid=1624) INFO 09-24 21:05:08 [loggers.py:123] Engine 000: Avg prompt throughput: 10.4 tokens/s, Avg generation throughput: 30.9 tokens/s, Running: 4 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.2%, Prefix cache hit rate: 60.2%
(APIServer pid=1624) INFO 09-24 21:05:18 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 118.4 tokens/s, Running: 4 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.7%, Prefix cache hit rate: 60.2%
(APIServer pid=1624) INFO 09-24 21:05:28 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 117.6 tokens/s, Running: 4 reqs, Waiting: 0 reqs, GPU KV cache usage: 1.2%, Prefix cache hit rate: 60.2%
(APIServer pid=1624) INFO 09-24 21:05:38 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 116.4 tokens/s, Running: 4 reqs, Waiting: 0 reqs, GPU KV cache usage: 1.7%, Prefix cache hit rate: 60.2%
(APIServer pid=1624) INFO 09-24 21:05:48 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 117.2 tokens/s, Running: 4 reqs, Waiting: 0 reqs, GPU KV cache usage: 2.1%, Prefix cache hit rate: 60.2%
(APIServer pid=1624) INFO 09-24 21:05:58 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 116.4 tokens/s, Running: 4 reqs, Waiting: 0 reqs, GPU KV cache usage: 2.6%, Prefix cache hit rate: 60.2%
(APIServer pid=1624) INFO 09-24 21:06:08 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 116.8 tokens/s, Running: 4 reqs, Waiting: 0 reqs, GPU KV cache usage: 3.1%, Prefix cache hit rate: 60.2%
(APIServer pid=1624) INFO 09-24 21:06:18 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 108.2 tokens/s, Running: 2 reqs, Waiting: 0 reqs, GPU KV cache usage: 1.8%, Prefix cache hit rate: 60.2%
(APIServer pid=1624) INFO 09-24 21:06:28 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 25.5 tokens/s, Running: 0 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.0%, Prefix cache hit rate: 60.2%
(APIServer pid=1624) INFO 09-24 21:06:38 [loggers.py:123] Engine 000: Avg prompt throughput: 0.0 tokens/s, Avg generation throughput: 0.0 tokens/s, Running: 0 reqs, Waiting: 0 reqs, GPU KV cache usage: 0.0%, Prefix cache hit rate: 60.2%
