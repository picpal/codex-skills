---
name: obsidian-capture
description: Use when saving raw thoughts, CLI sessions, links, videos, YouTube transcripts, OCR books, images, files, and website material into an Obsidian second-brain vault without forcing early classification.
---

# Obsidian Capture

Use this skill when the user wants to save a thought, note, CLI session, URL, video link, YouTube transcript, OCR book scan, image, file, web page, or raw material into their Obsidian second brain.

## Core Rule

Capture must be low-friction. Do not force the user to classify the material before saving it.

## Inputs

- Freeform thought
- Quick note
- CLI session transcript or summary
- URL or web page
- Video link, including YouTube
- Video transcript, subtitles, captions, or timestamp notes
- OCR book text, scanned book PDF, chapter excerpt, or reading note
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
   - `20_Sources/books/raw` for large OCR PDFs, scanned book PDFs, OCR text exports, and raw book files.
   - `20_Sources/books` for book index notes, chapter Source notes, sections, and book excerpts.
   - `20_Sources/documents` for generic documents and PDFs.
   - `20_Sources/papers` for academic papers and reports.
4. For YouTube or video links, try to capture transcript-backed meaning, not just the URL:
   - Preserve the durable video URL.
   - Capture available title, channel, publish date, duration, and transcript availability when accessible.
   - If subtitles, captions, or a user-provided transcript are available, summarize from that text.
   - Add timestamp notes when the transcript or page provides usable time anchors.
   - If transcript access is unavailable, set `status: needs_transcript` and do not infer detailed content from the title alone.
5. For OCR books, preserve the source pointer and split long material:
   - Store book OCR material under `20_Sources/books`.
   - Store large raw OCR PDFs and scan files under `20_Sources/books/raw`.
   - Create one book-level Source note as an index when the book is large.
   - Treat the Book Index as a routing note, not final answer evidence.
   - Create chapter or section Source notes when a single note would become too long.
   - Record title, author, edition if known, OCR quality, page or chapter range, and file location.
   - Add `chunking_strategy`, `chunk_unit`, `chunk_quality`, `retrieval_ready`, and `evidence_level` when creating OCR book notes.
   - If chunk Source notes do not exist yet, use `retrieval_ready: partial` or `retrieval_ready: no`.
   - If a chunk is too large or mixes multiple claims, set `chunk_quality: too_large` and `status: needs_rechunk`.
   - Summarize and extract compile candidates from the OCR text, but keep uncertain OCR readings marked as low confidence.
6. Create a Source or Capture note with metadata.
7. Set `status: captured`, `status: needs_classification`, `status: needs_transcript`, `status: needs_ocr_review`, or `status: needs_rechunk`.
8. Add compile candidates for concepts, claims, questions, insights, projects, or decisions when the source content supports them.
9. Add a short processing note that suggests the next compile step.

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

## OCR Book Capture Requirements

For OCR books, scanned books, or chapter text, the Source note should include:

- `## Original`: book title, author, edition, local file path or source pointer, and scope.
- `## OCR Basis`: OCR source, OCR quality, language, page or chapter range, and review status.
- `## Summary`: one to five lines for the captured scope.
- `## Key Points`: main concepts, claims, examples, methods, and definitions.
- `## Location Notes`: page, chapter, heading, or section anchors when available.
- `## Chunking Plan`: strategy, unit, quality, and rechunk candidates.
- `## Retrieval Safety`: retrieval readiness, evidence level, and answer scope.
- `## Compile Candidates`: candidate Concept, Claim, Question, Insight, Project, or Decision notes.
- `## OCR Text or Excerpts`: only the needed excerpt, or a pointer to the local OCR file when the text is long.
- `## Processing Notes`: next step, OCR cleanup needs, and split/merge notes.

Prefer `20_Sources/books` for book material. Use `20_Sources/documents` only when the material is not book-like. Do not turn a whole book into one giant note if chapter or section notes would make retrieval easier.

Book Index notes are not sufficient answer evidence. They should point to chunk Source notes. Use `retrieval_ready: no` or `retrieval_ready: partial` until chunk Source notes and source locations exist.

## Safety

- Never overwrite raw source content.
- Do not invent source details.
- If classification is uncertain, use `needs_classification`.
- If a video has no accessible transcript or captions, use `needs_transcript`.
- If OCR quality is poor or page boundaries are uncertain, use `needs_ocr_review`.
- Do not summarize a video in detail from title, thumbnail, or comments alone.
- Do not treat OCR text as exact evidence when the scan quality is uncertain.
- Do not expose long copyrighted book text in chat output by default. Keep private OCR source material in the vault and work from summaries, location notes, and short excerpts unless the user explicitly asks otherwise.
- If chunk boundaries are too broad or mixed, use `needs_rechunk`.
- Do not promote index-only content into strong Claim or Insight notes.
- Do not mark OCR book material as `retrieval_ready: yes` unless chunk Source notes and source locations exist.
- If evidence is weak, set `confidence: low`.

## References

- `../../shared/obsidian-second-brain/references/vault-structure.md`
- `../../shared/obsidian-second-brain/references/note-types.md`
- `references/capture-workflow.md`
- `references/video-transcript-workflow.md`
- `references/book-ocr-workflow.md`
