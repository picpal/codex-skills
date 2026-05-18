---
type: source
created: "{{date}}"
source_type: book_ocr
status: captured
confidence: medium
title: "{{book_title}}"
author: "{{author_or_unknown}}"
scope: "{{scope}}"
ocr_quality: medium
page_boundary_confidence: medium
chunking_strategy: "{{chunking_strategy}}"
chunk_unit: "{{chunk_unit}}"
chunk_quality: "{{chunk_quality}}"
retrieval_ready: partial
evidence_level: index_only
answer_scope: book
related_maps: []
related_objects: []
related_projects: []
---

# Book OCR - {{book_title}} - {{scope}}

## Original

- Title: {{book_title}}
- Author: {{author_or_unknown}}
- Edition: {{edition_or_unknown}}
- Raw PDF: {{raw_pdf_path_or_pointer}}
- OCR Text: {{ocr_text_path_or_pointer}}
- Scope: {{whole_book_or_chapter_or_page_range}}
- Language: {{language_or_unknown}}

## Quality Gate

- OCR quality: low | medium | high
- Page boundary confidence: low | medium | high
- Missing pages: unknown | no | yes
- Review status: captured | needs_ocr_review

## Table of Contents

- {{chapter_or_section_outline}}

## Chunking Plan

- chunking_strategy: toc | heading | page_range | semantic | manual
- chunk_unit: chapter | section | claim | page_range
- chunk_quality: good | uneven | too_large | uncertain
- rechunk_candidates: []

## Chunk Index

- [[{{book_slug}}-ch01]] - status: raw_only | indexed | chunked | compiled | needs_ocr_review | needs_rechunk

## Topic Candidates

- Related maps:
- Concepts:
- Questions:

## Summary

{{short_scope_summary}}

## Key Points

- {{point}}

## Location Notes

- {{page_or_chapter_or_heading}} - {{note}}

## Compile Candidates

- Concept:
- Claim:
- Question:
- Insight:
- Project:
- Decision:

## OCR Text or Excerpts

{{short_excerpt_or_pointer_to_raw_ocr}}

## Processing Notes

- status: raw_only | indexed | chunked | compiled | needs_ocr_review | needs_rechunk
- retrieval_ready: yes | partial | no
- evidence_level: source_verified | index_only | weak_ocr | needs_review
- next_step: create or review chunk Source notes before using this book as answer evidence
