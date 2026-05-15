---
name: obsidian-retrieve
description: Retrieve evidence-linked answers from an Obsidian second-brain vault and save new insights, questions, decisions, or outputs when retrieval creates value.
---

# Obsidian Retrieve

Use this skill when the user asks a question that should be answered from the Obsidian second-brain vault.

## Core Rule

Start from Maps, then follow Object links, then open Source notes for evidence. Distinguish evidence from inference.

## Workflow

1. Identify the question and relevant topic area.
2. Read relevant `40_Maps` notes first.
3. Follow links into `30_Objects`.
4. Open supporting `20_Sources`.
5. Answer with evidence links and confidence.
6. If retrieval creates new value, save a candidate:
   - Insight
   - Question
   - Decision
   - Project action
   - Output note

## Answer Format

Use:

```markdown
## Answer

{{answer}}

## Evidence

- [[source-note]]: {{why_it_matters}}

## Inference

{{what_is_reasoned_beyond_sources}}

## Confidence

low | medium | high

## New Memory Candidates

- Insight:
- Question:
- Decision:
- Project action:
- Output:
```

## Safety

- Do not hide weak evidence.
- Do not answer from memory alone when vault notes are available.
- Mark missing evidence as `needs_evidence`.

## References

- `../shared/obsidian-second-brain/references/workflows.md`
- `../shared/obsidian-second-brain/references/reliability.md`
- `references/retrieve-workflow.md`
