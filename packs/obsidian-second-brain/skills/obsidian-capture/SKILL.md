---
name: obsidian-capture
description: Use when saving raw thoughts, CLI sessions, links, videos, YouTube transcripts, images, files, and website material into an Obsidian second-brain vault without forcing early classification.
---

# Obsidian Capture

Use this skill when the user wants to save a thought, note, CLI session, URL, video link, YouTube transcript, image, file, web page, or raw material into their Obsidian second brain.

## Core Rule

Capture must be low-friction. Do not force the user to classify the material before saving it.

## Inputs

- Freeform thought
- Quick note
- CLI session transcript or summary
- URL or web page
- Video link, including YouTube
- Video transcript, subtitles, captions, or timestamp notes
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
   - `20_Sources/videos` for video links, transcripts, captions, and timestamp summaries.
   - `20_Sources/images` for image references.
   - `20_Sources/documents` for documents.
4. For YouTube or video links, try to capture transcript-backed meaning, not just the URL:
   - Preserve the durable video URL.
   - Capture available title, channel, publish date, duration, and transcript availability when accessible.
   - If subtitles, captions, or a user-provided transcript are available, summarize from that text.
   - Add timestamp notes when the transcript or page provides usable time anchors.
   - If transcript access is unavailable, set `status: needs_transcript` and do not infer detailed content from the title alone.
5. Create a Source or Capture note with metadata.
6. Set `status: captured`, `status: needs_classification`, or `status: needs_transcript`.
7. Add compile candidates for concepts, claims, questions, insights, projects, or decisions when the source content supports them.
8. Add a short processing note that suggests the next compile step.

## Required Metadata

- `type`
- `created`
- `source_type`
- `status`
- `confidence`
- `related_maps`
- `related_objects`
- `related_projects`

## Video Capture Requirements

For YouTube or video links, the Source note should include:

- `## Original`: durable URL and available metadata.
- `## Transcript Basis`: transcript source, language, access status, and confidence.
- `## Summary`: one to five lines based on transcript/captions when available.
- `## Key Points`: main ideas, claims, examples, and methods.
- `## Timestamp Notes`: important moments when timestamps are available.
- `## Compile Candidates`: candidate Concept, Claim, Question, Insight, Project, or Decision notes.
- `## Processing Notes`: next step and any transcript gaps.

Do not paste long copyrighted transcripts by default. Prefer transcript-based summaries, timestamp notes, and short evidence excerpts. If the user provides their own transcript and asks to preserve it, store it as source material while keeping summaries separate.

## Safety

- Never overwrite raw source content.
- Do not invent source details.
- If classification is uncertain, use `needs_classification`.
- If a video has no accessible transcript or captions, use `needs_transcript`.
- Do not summarize a video in detail from title, thumbnail, or comments alone.
- If evidence is weak, set `confidence: low`.

## References

- `../../shared/obsidian-second-brain/references/vault-structure.md`
- `../../shared/obsidian-second-brain/references/note-types.md`
- `references/capture-workflow.md`
- `references/video-transcript-workflow.md`
