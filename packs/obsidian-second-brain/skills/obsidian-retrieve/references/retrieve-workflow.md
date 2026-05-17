# Retrieve Workflow

## Search Order

1. `40_Maps`
2. `30_Objects`
3. `20_Sources`
4. `50_Execution`
5. `60_Reviews`

## Evidence Rules

- Link Source notes whenever possible.
- Separate evidence from inference.
- Assign confidence.
- Create follow-up Question notes when evidence is missing.

## OCR Book Evidence Rules

- Book Index notes route retrieval; they do not settle answers.
- Prefer chunk Source notes with page, chapter, or heading anchors.
- Use `evidence_level: source_verified` only when the answer points to a chunk Source and raw location.
- Use `evidence_level: index_only` when only Book Index metadata exists.
- Use `evidence_level: weak_ocr` when OCR quality or page boundaries are weak.
- Use `evidence_level: needs_review` when human review is needed before strong claims.

## Writeback Rules

When a retrieval session produces a useful new connection, save it as an Insight candidate.

When it produces a choice, save it as a Decision candidate.

When it produces a concrete next step, link it to a Project note or create a Project action candidate.

When it produces a reusable answer, artifact, or synthesis, save or link it as an Output note candidate.
