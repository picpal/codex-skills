# Lint Workflow

## Checks

### Orphan Notes

Notes with no meaningful links to Sources, Maps, Objects, Projects, or Reviews.

### Merge Candidates

Notes with similar names, aliases, definitions, or repeated summaries.

### Stale Claims

Claim notes whose review date has passed or whose confidence is low without follow-up.

### Outdated Decisions

Decision notes whose review condition or date has been reached.

### Missing Evidence

Claim, Insight, or Decision notes without Source links.

### OCR Book Quality Issues

Book OCR material that can lower retrieval quality.

Flag:

- Book Index notes with long whole-book summaries.
- Book Index notes with `retrieval_ready: yes` and no chunk Source links.
- Chunk Source notes with `chunk_quality: too_large` that already produced Concept, Claim, or Insight notes.
- Claim or Insight notes derived from OCR books without page, chapter, heading, or chunk links.
- Notes marked `needs_ocr_review` without a next review action.

### Broken Links

Links to notes, headings, embeds, or source references that no longer resolve.

### Unresolved Questions

Question notes that remain open and have no next exploration step.

## Lint Report Format

```markdown
---
type: lint_report
created: "{{date}}"
---

# Lint Report - {{date}}

## Orphan Notes

- [[note]]: reason

## Merge Candidates

- [[note-a]] + [[note-b]]: similarity

## Stale Claims

- [[claim]]: review reason

## Decisions Needing Review

- [[decision]]: review condition

## Missing Evidence

- [[note]]: missing source link

## OCR Book Quality Issues

- [[note]]: issue and suggested review action

## Broken Links

- [[note]]: broken link target

## Unresolved Questions

- [[question]]: missing next exploration

## Suggested Next Actions

- {{action}}
```
