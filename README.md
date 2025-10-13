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

## IT Infra for containerized (AI) workloads
```mermaid
graph TD
    A[Open Source Container Registry]
    HF[Huggingface]
    B[On Demand Cloud GPU Server]
    HELM[helm chart describing deployment]
    C[Harbor Image Registry]
    D[Azure DevOps Repos]
    S3[S3 Object Storage]
    E[GPU Server 2xRTX4090]
    F[GPU Server 8xL40S]

    subgraph VAST_AI[vast.ai]
        B
    end
    subgraph UAT_OC[IBIC Namespace]
        E
    end
    subgraph PROD_OC[IBIC Namespace]
        F
    end

    subgraph DEV[DEV]
        VAST_AI
    end
    subgraph UAT[UAT OpenShift]
        UAT_OC
    end
    subgraph PROD[PROD OpenShift]
        PROD_OC
    end

    subgraph Intranet[Intranet]
        C
        D
        S3
        HELM
        UAT
        PROD
    end

    subgraph Internet[Internet]
        A
        HF
        DEV
    end

    A -- Test new Docker images --> B
    HF -- Test new ML models --> B

    Internet -- Onboard tested Docker images --> C
    Internet -- Onboard tested AI models --> S3

    HELM -- version in --> D
    C --> HELM
    S3 --> HELM

    HELM -- deploy via Azure DevOps Pipelines --> UAT_OC
    UAT -- promote tested product --> PROD
```

## Open topics
1. Can we have a fully disconected environment (equivaltent to a private laptop) to:
   - simulate our prod server in cloud for testing without data
   - quickly develop sultions that do not need BJSS data
   - test new docker images before onboarding them
   - test new AI models before onboarding them
2. Is there an automated process to onboard new docker images?
3. Is there any Object storage that we can use to store our AI models? We would need to be able to download from it from our Servers.
4. What is the central solution BJSS to version code and create CI/CD pipelines?
5. Can our Servers be integrated into OpenShift? Can we get Namespace in OpenShift?
6. Do we need an alterantive to OpenShift? E.g. plain k8s or k3s?
