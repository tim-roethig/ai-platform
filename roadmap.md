# Roadmap
---

### 1. Mature inference infrastructure
Known Issues:
- short context of only 4k/8k tokens depending on the model
- limited parallelism
- too many models hosted in parallel 
  - => no VRAM left for KV cache => short context and limited parallelism
  - => models are not always loaded into GPU memory which can cause delays

Proposal:
- focus on just one model (Qwen3 VL 235b)
- use vLLM for faster processing

---

### 2. Consolidate LeoGPT UI and functionalities 
Known Issues:
- LeoGPT currently has many features and models that do not work reliable and confuse people
- UI crashes sometimes when
- Translation of text in images not working atm

Proposal:
- focus one core feature e.g. just a simple multimodal chat that people can use safely
  - => This could also be used for translating documents with text in images

---

### 3. Implementation of the First Use Case
This step is critical to the success of the Journey. With the infrastructure in place, we will implement the first Safra-specific use case. It is essential to select a use case that is impactful and aligns with organizational priorities. The use case should have measurable outcomes to demonstrate value and justify future investments.

---

### 4. Upskilling Staff
To ensure effective adoption of AI tools, we will develop a training program that includes:
1. A foundational understanding of AI, with a focus on generative AI.
2. Guidance on how to use the developed products effectively.

---

### 5. Production Maintenance and Additional Use Cases
Following the successful implementation of the first use case, we will focus on:
- Maintaining and enhancing the existing use case.
- Identifying and implementing additional impactful use cases.
- Scaling development resources as demand increases, including onboarding additional AI engineers.

---

### 6. Professionalization of AI Infrastructure
As demand for AI solutions grows, we will professionalize the AI infrastructure by:
- Expanding GPU resources to support higher usage and establish lower environments (e.g., development environment) to minimize production downtime during development.
- Implementing advanced MLOps practices, including monitoring, redundancy, and CI/CD pipelines.
- Hiring a dedicated ML platform engineer to support these efforts.

---
