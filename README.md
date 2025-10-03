# Light weight Open Source AI platform
This repo should contain a light weight Open Source AI platform, coming with the basic needs to develop and host AI applications fully in house.

## Architecture
```mermaid
graph TD
    A[End User]
    B[Chat UI e.g. OpenWeb UI or LibreChat]
    C[Internal Products]
    D[chat API]
    E[embedding API]
    F[reranking API]
    G[LLM]
    H[embedding model]
    I[reranking model]
    K[Model Registry]
    L[Hugging Face]
    M[docling]
    N[DeepEval]


    A --- B
    A --- C
    B --- 1
    C --- 1
    G --- K
    H --- K
    I --- K
    K --- L
    B --- M
    N --- C
    N --- 1

    subgraph 1[vLLM]
        D --- G
        E --- H
        F --- I
    end
    subgraph 2[GPU Server]
        1
        M
    end
    subgraph 3[CPU Server]
        B
        C
    end
```

### Tool glossary
#### vLLM
vLLM is a famous LLM runner like ollama or Hugging Face TGIF. While ollama is designed for ease of use and is a great tool for end users, vLLM is designed for speed and production workloads. It should outperform ollama by a good margin in terms of inference speed and capacity. It evolved as the industry standard for production LLM inference.

#### OpenWeb UI / LibreChat
OpenWeb UI and LibreChat are open source chat frontends, offering similar capabilities like ChatGPT or Gemini. While OpenWeb UI has a larger user and developer base, it has a weird license. LibreChat on the other hand comes under MIT license.

#### docling
Docling is content extraction tool that uses AI models to preprocess various file formats to make them LLM/RAG ready, by e.g OCR or table extraction. It can improve performance of Chat frontends where users upload all kinds on different documents.

#### DeepEval
DeepEval is a LLM evaluation framework with e.g. LLM as judge implementations that can be used to evaluate LLM systems, when a test data set is present.

## Release process
```mermaid
graph TD
    A[Open Source Container Registry]
    B[Vast.ai GPU Servers]
    C[Harbor]
    D[Azure DevOps GIT]
    E[DEV GPU Server 2xRTX4090]
    F[PROD GPU Server 8xL40S]

    subgraph UAT_OC[UAT OpenShift]
        E
    end
    subgraph PROD_OC[PROD OpenShift]
        F
    end

    subgraph DEV[DEV]
        B
    end
    subgraph UAT[UAT]
        UAT_OC
    end
    subgraph PROD[PROD]
        PROD_OC
    end

    subgraph BJSS[BJSS]
        C
        UAT
        PROD
    end

    subgraph Internet[Internet]
        A
        DEV
    end
```
