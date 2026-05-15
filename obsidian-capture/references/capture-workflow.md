# Capture Workflow

## Filename Pattern

Use:

```text
YYYY-MM-DD-slug.md
```

For very short freeform thoughts, use:

```text
YYYY-MM-DD-HHMM-quick-thought.md
```

## Frontmatter Example

```yaml
---
type: source
created: "2026-05-15"
source_type: thought
status: captured
confidence: low
related_maps: []
related_objects: []
related_projects: []
---
```

## Body Structure

```markdown
# Title

## Original

Raw content or pointer.

## Summary

One to five lines.

## Processing Notes

- Status: captured
- Suggested next step: run obsidian-compile
```

## Ambiguous Input

When the material is unclear, save it anyway and mark:

```yaml
status: needs_classification
confidence: low
```
