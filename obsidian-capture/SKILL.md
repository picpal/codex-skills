---
name: obsidian-capture
description: Capture raw thoughts, CLI sessions, links, videos, images, files, and website material into an Obsidian second-brain vault without forcing early classification.
---

# Obsidian Capture

Use this skill when the user wants to save a thought, note, CLI session, URL, video link, image, file, web page, or raw material into their Obsidian second brain.

## Core Rule

Capture must be low-friction. Do not force the user to classify the material before saving it.

## Inputs

- Freeform thought
- Quick note
- CLI session transcript or summary
- URL or web page
- Video link
- Image or file reference
- Text excerpt

## Workflow

1. Identify or ask for the vault path if it is not available from context.
2. Preserve the raw input or pointer.
3. Choose the lightest safe destination:
   - `10_Capture/inbox` for quick thoughts.
   - `10_Capture/unprocessed` for ambiguous material.
   - `20_Sources/sessions` for CLI sessions.
   - `20_Sources/web` for web pages and URLs.
   - `20_Sources/videos` for video links.
   - `20_Sources/images` for image references.
   - `20_Sources/documents` for documents.
4. Create a Source or Capture note with metadata.
5. Set `status: captured` or `status: needs_classification`.
6. Add a short processing note that suggests the next compile step.

## Required Metadata

- `type`
- `created`
- `source_type`
- `status`
- `confidence`
- `related_maps`
- `related_objects`
- `related_projects`

## Safety

- Never overwrite raw source content.
- Do not invent source details.
- If classification is uncertain, use `needs_classification`.
- If evidence is weak, set `confidence: low`.

## References

- `../shared/obsidian-second-brain/references/vault-structure.md`
- `../shared/obsidian-second-brain/references/note-types.md`
- `references/capture-workflow.md`
