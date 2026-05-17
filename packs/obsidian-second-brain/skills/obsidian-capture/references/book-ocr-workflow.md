# Book OCR Workflow

Use this workflow when the input is an OCR scan of a book, a scanned PDF, chapter text, or a local OCR file.

## Destination

Use `20_Sources/books` for book material.

Recommended layout:

```text
20_Sources/books/
  raw/
    book-title.pdf
    book-title-ocr.txt
  YYYY-MM-DD-book-title.md
  YYYY-MM-DD-book-title-ch01.md
  YYYY-MM-DD-book-title-ch02.md
```

Put OCR PDFs, scanned PDFs, OCR text exports, and other large raw book files in `20_Sources/books/raw`. If the user already has files outside the vault, keep a durable local path in `## Original`. If the user puts the OCR files inside the vault, keep large raw OCR files as source material and create smaller Source notes for summaries, location notes, and compile candidates.

## Capture Strategy

1. Preserve the original source pointer before summarizing.
2. Detect whether the input is a whole book, chapter, section, or excerpt.
3. If it is long, create or update a book-level index note and split by chapter or section.
4. Record title, author, edition, source file, scope, language, OCR quality, and page or chapter range.
5. Summarize only the captured scope.
6. Extract key concepts, claims, questions, definitions, examples, and methods.
7. Add location notes using page, chapter, heading, or section anchors.
8. Mark uncertain OCR readings with `confidence: low` or `status: needs_ocr_review`.
9. Add compile candidates for future `obsidian-compile`.

## Book Index Rules

Book Index is a routing note, not answer evidence. It should help find chunk Source notes and raw locations.

Include:

- Title, author, edition, language, raw PDF path, and OCR text path.
- OCR quality, page boundary confidence, missing page status, and review status.
- Table of contents or estimated outline.
- Chunking plan and chunk Source links.
- Topic candidates and related map candidates.
- Processing notes with next step.

Do not include:

- Long whole-book summaries.
- Strong conclusions without source locations.
- Claim or Insight content that cannot point back to a chunk or raw location.
- Long OCR text.
- Mixed statements where the author's claim and the user's interpretation are not separated.

## Chunk Boundary Policy

Index rules do not guarantee chunk quality. Use this boundary policy when creating chapter or section Source notes.

Boundary priority:

1. Follow the book's explicit table of contents.
2. If the table of contents is missing or broken by OCR, follow headings.
3. If headings are unstable, use page ranges.
4. If one chunk contains multiple core claims, split by semantic or claim-level boundaries.
5. If a human decision is required, use `chunking_strategy: manual` and `status: needs_rechunk`.

Good chunks:

- Read as one chapter, section, argument, or claim unit.
- Include page, chapter, or heading anchors.
- Separate summary, key points, and location notes.
- State OCR quality.

Weak chunks:

- Are too long to use as focused evidence.
- Mix unrelated topics.
- Lack page or heading anchors.
- Have many OCR errors with medium or high confidence.
- Mix author claims with user interpretation.

Use `chunk_quality: good | uneven | too_large | uncertain`.
Use `status: needs_rechunk` when chunk boundaries need another pass.

## Status Rules

- `captured`: OCR is readable enough to summarize and compile later.
- `needs_ocr_review`: OCR has obvious recognition errors, missing pages, bad page boundaries, or unclear language.
- `needs_classification`: The material may be a book excerpt, report, paper, or note, and the type is uncertain.

## Copyright and Output Rule

Do not paste long copyrighted book text in chat output by default. In the vault, preserve the user's private source or pointer, then work from summaries, location notes, short excerpts, and compile candidates. If the user explicitly asks to keep the full OCR text in the vault, store it as source material and keep derived summaries separate.

## Compile Handoff

Good compile candidates from books include:

- Concept: recurring term, model, framework, definition, method.
- Claim: author assertion that needs evidence or comparison.
- Question: unresolved issue or contradiction.
- Insight: connection between the book and existing maps/projects.
- Project: practice, research, writing, product, or learning plan.
- Decision: change in workflow, tool choice, or research direction.

## Retrieval Safety Handoff

Set `retrieval_ready` conservatively.

- `retrieval_ready: yes`: chunk Source notes exist and evidence locations are usable.
- `retrieval_ready: partial`: index exists, but only some chunks are ready.
- `retrieval_ready: no`: raw file or index exists, but evidence chunks are missing or unreliable.

Set `evidence_level` conservatively.

- `source_verified`: answer can point to chunk Source and raw location.
- `index_only`: only Book Index metadata exists.
- `weak_ocr`: OCR quality or page boundaries are weak.
- `needs_review`: human review is needed before strong claims.

Book Index must not be used as final answer evidence. It routes the retrieval process to chunk Source notes.
