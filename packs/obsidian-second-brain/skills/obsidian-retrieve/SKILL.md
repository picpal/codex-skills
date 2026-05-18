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

## OCR Book Retrieval

When a question touches OCR book material:

1. Use Book Index notes only to find candidate chunk Source notes.
2. Open the related Chapter or Section Source before answering.
3. Check `retrieval_ready`, `evidence_level`, `ocr_quality`, and `chunk_quality`.
4. If evidence is `index_only`, answer narrowly and state that chunk evidence is missing.
5. If evidence is `weak_ocr` or `needs_review`, lower confidence and state the OCR limitation.
6. If `chunk_quality: too_large`, suggest rechunking or ask for a narrower scope before making detailed claims.

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

## Evidence Level

source_verified | index_only | weak_ocr | needs_review

## Answer Scope

book | chapter | section | claim

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
- Do not answer from Book Index alone when chunk Source notes are required.
- Do not treat `needs_ocr_review` material as high-confidence evidence.
- If `retrieval_ready` is `partial` or `no`, state what evidence is missing.

## References

- `../../shared/obsidian-second-brain/references/workflows.md`
- `../../shared/obsidian-second-brain/references/reliability.md`
- `references/retrieve-workflow.md`
