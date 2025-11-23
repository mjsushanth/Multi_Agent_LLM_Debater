# Multi-Agent LLM Debate Framework

A modular framework for orchestrating structured debates between multiple large language models (LLMs) with specialized judge evaluation. This project implements an adversarial training approach to enhance LLM argumentative reasoning.

## Features

- **Multi-Agent Architecture**: Orchestrates debates between opposing LLM agents
- **Structured Debate Protocol**: Implements formal opening, rebuttal, and closing rounds
- **Adversarial Critique System**: Agents analyze and critique opposing arguments
- **Evidence Self-Check Mechanism**: Ensures factual accuracy and reduces source fabrication
- **Multi-Dimensional Judge Framework**: Seven specialized judges evaluate different aspects of argument quality
- **Local-Based**: Compatible with Ollama-hosted models

## Requirements

- Python 3.8+
- [Ollama](https://ollama.ai/) for local model hosting
- YAML for configuration files
- Required Python packages (see Environment Setup)

## Installation

### Environment Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/[username]/multi-agent-llm-debate.git
   cd multi-agent-llm-debate
   ```

2. Create and activate the conda environment:
   ```bash
   conda env create -f debate-env.yml
   conda activate debate-env
   ```

3. Install Ollama following instructions at [ollama.ai](https://ollama.ai/download)

4. Download required models via Ollama: It's present in the first cell code which can be edited. Selective downloads / Download All can be done.


### High-Level Debate Orchestration Flow:
```
┌──────────────────────────────────────────────────────────────────────────────┐
│                           PREPARATION & CONFIG LAYER                         │
│  YAML Prompts → Theory Integration → Judge Config → Model Selection         │
└──────────────────────────────────────────────────────────────────────────────┘
                                        ↓
┌──────────────────────────────────────────────────────────────────────────────┐
│                           DEBATE EXECUTION LAYER                             │
│  Agent Init → Round Control → Evidence Check → Critique Gen → Response      │
│  (FOR/AGAINST) → (Opening/Rebuttal/Closing) → (Invisible Prep) → (Output)   │
└──────────────────────────────────────────────────────────────────────────────┘
                                        ↓
┌──────────────────────────────────────────────────────────────────────────────┐
│                         MULTI-JUDGE EVALUATION LAYER                         │
│  7 Specialized Judges → Parallel Scoring → Consensus Algorithm → Meta-Judge │
│  (Logic/Fact/Rhetoric/Strategy/Ethics/Belief/Audience) → Weighted Aggregate │
└──────────────────────────────────────────────────────────────────────────────┘
                                        ↓
┌──────────────────────────────────────────────────────────────────────────────┐
│                         STORAGE & PERSISTENCE LAYER                          │
│  JSON Debate Logs → Judgment Records → Transcript Generation → Results API  │
└──────────────────────────────────────────────────────────────────────────────┘
```

### Preparation Pipeline (Per Round)

```
═══════════════════════════════════════════════════════════════════════════════════════════════

  EVIDENCE CHECK TRACK:
  ─────────────────────
  Previous Response → Claim Extraction → Source Verification → Strength Analysis
        ↓                    ↓                   ↓                    ↓
  [Self-Critique]    [Find Claims]    [Check Citations]    [Rate: Strong/Med/Weak]
                                                                      ↓
                                                            {evidence_report.json}
                                                                      ↓
═══════════════════════════════════════════════════════════════════════════════════════════════
                                                                      ↓
  ADVERSARIAL CRITIQUE TRACK:                                        ↓
  ────────────────────────────                                       ↓
  Opponent Argument → 5-Dim Weakness Detection → Vulnerability Map   ↓
        ↓                         ↓                      ↓           ↓
  [Latest Args]    [Logic/Fact/Assume/Rhetoric/Strategy] [Counter]   ↓
                                                            ↓         ↓
                                                    {critique.json}   ↓
                                                            ↓         ↓
═══════════════════════════════════════════════════════════════════════════════════════════════
                                                            ↓         ↓
  ENHANCED PROMPT ASSEMBLY:                                ↓         ↓
  ──────────────────────────                               ↓         ↓
  Base Debate Prompt + {evidence_report} + {critique} → Merge → Token Optimize → Final Prompt
                                                                        ↓
                                                              [Generate Response]
                                                                        ↓
═══════════════════════════════════════════════════════════════════════════════════════════════
```

### Evaluation & Consensus Architecture
```
INPUT: {combined_arguments, topic, stance, word_limit}
                            ↓
    ┌───────────────────────────────────────────────────────┐
    │              PARALLEL JUDGE EVALUATION                 │
    └───────────────────────────────────────────────────────┘
                            ↓
    ╔═══════════════════════════════════════════════════════╗
    ║                                                       ║
    ║  LOGICAL_JUDGE     → Fallacy Detection                ║ → Score: 8.1/10
    ║                      Internal Consistency             ║   Critique: 300 words
    ║                      Reasoning Chains                 ║
    ║                                                       ║
    ║  FACTUAL_JUDGE     → Source Verification              ║ → Score: 7.4/10
    ║                      Evidence Quality                 ║   Critique: 300 words
    ║                      Citation Integrity               ║
    ║                                                       ║
    ║  RHETORICAL_JUDGE  → Persuasion Analysis              ║ → Score: 8.5/10
    ║                      Emotional Appeal                 ║   Critique: 300 words
    ║                      Language Effectiveness           ║
    ║                                                       ║
    ║  STRATEGIC_JUDGE   → Argument Selection               ║ → Score: 7.8/10
    ║                      Adaptive Response                ║   Critique: 300 words
    ║                      Framing Control                  ║
    ║                                                       ║
    ║  ETHICAL_JUDGE     → Fair Representation              ║ → Score: 9.2/10
    ║                      Intellectual Honesty             ║   Critique: 300 words
    ║                      Respectful Conduct               ║
    ║                                                       ║
    ║  BELIEF_JUDGE      → Audience Impact                  ║ → Score: 6.9/10
    ║                      Mind-Change Potential            ║   Critique: 300 words
    ║                      Cross-Segment Appeal             ║
    ║                                                       ║
    ║  AUDIENCE_JUDGE    → Comprehension (4 dims)           ║ → Score: 7.5/10
    ║                      Engagement Metrics               ║   Panel Response: 300 words
    ║                                                       ║
    ╚═══════════════════════════════════════════════════════╝
                            ↓
    ┌───────────────────────────────────────────────────────┐
    │               META-JUDGE CONSENSUS                    │
    │                                                       │
    │  • Inter-Judge Correlation (r = 0.64-0.91)          │
    │  • Composite Score Calculation                       │
    │                                                       │
    │  FINAL OUTPUT:                                       │
    │  ─────────────                                       │
    │  Composite Score: 7.7/10                            │
    │  Consensus Strengths: [...]                         │
    │  Consensus Weaknesses: [...]                        │
    │  Definitive Assessment: 300 words                   │
    └───────────────────────────────────────────────────────┘
```



## 📁 Project Structure

```
.
├── .ipynb_checkpoints/     # Jupyter notebook checkpoints
├── prompts/                # YAML configuration files for debate prompts
│   ├── debate_prompts.yml  # Core debate prompts
│   ├── judge_prompts.yml   # Judge evaluation prompts
├── results/                # Debate outputs and judge evaluations
│   ├── agent_records/      # Saved debate transcripts
│   ├── judge_records/      # Evaluation results
│   ├── perfect_debate_transcripts/ # Curated debate examples, for Judgement Pipeline
├── debate-env.yml          # Conda environment configuration
├── MultiLLM Debate.ipynb   # Main notebook for running debates
├── OLLAMA EDA, Test Scripts.ipynb # Ollama exploration and testing scripts
```

## Core Components

### 1. Prompt Management System

- `PromptManager` class loads and formats debate prompts from YAML files
- Modular design allows testing different prompt strategies
- Phase-specific guidance for opening, rebuttal, and closing rounds

### 2. Multi-Agent Debate Engine

- `MultiAgentDebate` class orchestrates structured interactions
- Implements preparation, critique, and rebuttal phases
- Manages context and maintains debate state
- Generates enhanced arguments based on adversarial feedback

### 3. Judge Evaluation Pipeline

- `JudgeEvaluator` class assesses debate quality across multiple dimensions
- Specialized judges for logical, factual, rhetorical, and ethical aspects
- Meta-judge synthesizes evaluations into composite assessment


## Customization

### Modifying Debate Prompts

Edit the YAML files in the `prompts/` directory to customize:
- Debate instructions and structure
- Critique guidelines
- Evidence check parameters
- Judge evaluation criteria


### Adding New Models

Update the `OllamaDebateManager.models` dictionary to include new models:

```python
self.models = {
    "custom_model": "model_name:tag",
    # Add more models here
}
```

## Results and Evaluation

Debate results and judge evaluations are saved to:
- `results/agent_records/` - Full debate transcripts
- `results/judge_records/` - Judge evaluations and scores


## Skills Picked Up:
- Agent Coordination, Persistent Memory Systems, Inter-Agent Communication, Scalable Agent Framework.
- API Integration.
- Model Orchestration (Custom class handling model lifecycle, health checks, and failover mechanisms.)
- Assessment: Scoring Algorithms, Meta-Evaluation, Performance Metrics.
- YAML-Based Configuration, Parameter Management.

## Citation
If you use this framework in your research, please cite:

```
@misc{markapudi2025socraiticcircle,
  title={SocrAItic Circle: Enhancing LLM Reasoning Through Multi-Agent Debate Frameworks},
  author={Markapudi, Joel},
  year={2025},
  institution={Northeastern University}
}
```

## Contributions
TBD

## License
Authorship of all Code Notebooks, Environment Setup, Prompts Files - Joel Markapudi.  
