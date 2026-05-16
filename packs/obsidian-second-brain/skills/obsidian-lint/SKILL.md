---
name: obsidian-lint
description: Review an Obsidian second-brain vault for orphan notes, duplicate concepts, stale claims, weak evidence, broken links, unresolved questions, and outdated decisions.
---

# Obsidian Lint

Use this skill when the user wants to clean up, review, or synthesize the health of their Obsidian second-brain vault.

## Core Rule

Lint produces review items and synthesis reports. It does not silently rewrite large parts of the vault.

## Workflow

1. Scan vault structure.
2. Find orphan notes.
3. Find duplicate or merge candidates.
4. Find stale claims and old decisions.
5. Find weak evidence and missing source links.
6. Find broken links.
7. Find unresolved questions.
8. Create a lint report in `60_Reviews/lint-reports`.
9. Update Home dashboard review items.

## Report Sections

- Orphan notes
- Merge candidates
- Stale claims
- Decisions needing review
- Missing evidence
- Broken links
- Unresolved questions
- Suggested next actions

## Safety

- Do not delete notes.
- Do not rewrite source content.
- Do not resolve contradictions automatically.
- Suggest changes clearly so the user can approve them.

## References

- `../../shared/obsidian-second-brain/references/workflows.md`
- `../../shared/obsidian-second-brain/references/reliability.md`
- `references/lint-workflow.md`
