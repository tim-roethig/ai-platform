# Roadmap

**Note**: The estimated time is based on a typical private environment and not a corporate environment, as the developer infrastructure at Safra is currently unknown.

---

### 1. LLM Inference Infrastructure
Currently, large language models (LLMs) are hosted using Ollama. While Ollama is effective for prototyping, it is not suitable for production-level inference. The plan is to transition from Ollama to vLLM, which will significantly enhance our inference capacity (by approximately 10x) and provide greater stability.

**Estimated time**: 0.5 days

---

### 2. Document Processing Engine
We anticipate use cases involving the processing of documents such as PDFs, Word files, and potentially even printed materials. To address this, we will deploy Docling, an open-source OCR and document processing engine. Docling will convert various document formats into Markdown, enabling better processing by LLMs.

**Estimated time**: 0.5 days

---

### 3. Simple User Interface for Chat
With the infrastructure in place, we can deploy a ChatGPT-like user interface. This interface will allow users to:
- Interact with the system as a general-purpose assistant.
- Chat with uploaded documents.
- Receive assistance with writing, coding, and other tasks.
- ...

Depending on GPU capacity, this interface can be made available to specific divisions or the entire organization, ensuring secure and efficient usage of AI models.

**Estimated time**: 0.5 days

---

### 4. Implementation of the First Use Case
This step is critical to the success of the Journey. With the infrastructure in place, we will implement the first Safra-specific use case. It is essential to select a use case that is impactful and aligns with organizational priorities. The use case should have measurable outcomes to demonstrate value and justify future investments.

**Estimated time**: To be determined

---

### 5. Upskilling Staff
To ensure effective adoption of AI tools, we will develop a training program that includes:
1. A foundational understanding of AI, with a focus on generative AI.
2. Guidance on how to use the developed products effectively.

**Estimated time**: 2 days

---

### 6. Production Maintenance and Additional Use Cases
Following the successful implementation of the first use case, we will focus on:
- Maintaining and enhancing the existing use case.
- Identifying and implementing additional impactful use cases.
- Scaling development resources as demand increases, including onboarding additional AI engineers.

---

### 7. Professionalization of AI Infrastructure
As demand for AI solutions grows, we will professionalize the AI infrastructure by:
- Expanding GPU resources to support higher usage and establish lower environments (e.g., development environment) to minimize production downtime during development.
- Implementing advanced MLOps practices, including monitoring, redundancy, and CI/CD pipelines.
- Hiring a dedicated ML platform engineer to support these efforts.

---