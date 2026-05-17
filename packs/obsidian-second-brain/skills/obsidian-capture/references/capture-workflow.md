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

## Video Link Body Structure

Use this structure for YouTube or video links:

```markdown
# YouTube - {{title}}

## Original

- URL: {{url}}
- Channel: {{channel_or_unknown}}
- Published: {{published_or_unknown}}
- Duration: {{duration_or_unknown}}

## Transcript Basis

- Transcript source: captions | subtitles | user-provided transcript | unavailable
- Language: {{language_or_unknown}}
- Access status: available | partial | unavailable
- Confidence: low | medium | high

## Summary

One to five lines based on transcript or captions.

## Key Points

- {{point}}

## Timestamp Notes

- {{timestamp}} - {{note}}

## Compile Candidates

- Concept:
- Claim:
- Question:
- Insight:
- Project:
- Decision:

## Processing Notes

- Status: captured | needs_transcript
- Suggested next step: run obsidian-compile
```

If transcript or captions are unavailable, keep the durable URL and metadata, set `status: needs_transcript`, and avoid detailed content claims.

## Ambiguous Input

When the material is unclear, save it anyway and mark:

```yaml
status: needs_classification
confidence: low
```
