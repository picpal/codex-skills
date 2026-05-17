# OCR Book Capture Quality Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Strengthen OCR book capture so raw PDFs, book indexes, chunks, retrieval, and lint rules preserve evidence quality and prevent index-only answers.

**Architecture:** This is a documentation-and-template implementation inside the existing `obsidian-second-brain` skill pack. It adds OCR book quality fields to templates, expands capture/retrieve/lint workflow rules, and updates verification scripts so the pack enforces the new conventions.

**Tech Stack:** Markdown skill files, Obsidian-flavored Markdown templates, Bash verification scripts, existing repo verification commands.

---

## File Structure

Files to modify:

- `packs/obsidian-second-brain/shared/obsidian-second-brain/templates/book-ocr-source.md`
  Shared template used by skill pack assets. It should contain the complete OCR book Source/Index shape.
- `packs/obsidian-second-brain/vault-template/00_System/templates/book-ocr-source.md`
  Vault template copy installed into user vaults. Keep it in sync with the shared template.
- `packs/obsidian-second-brain/skills/obsidian-capture/SKILL.md`
  Main trigger and safety rules for OCR book capture.
- `packs/obsidian-second-brain/skills/obsidian-capture/references/book-ocr-workflow.md`
  Detailed OCR book workflow. Add Book Index, Chunk Boundary Policy, and Retrieval Safety handoff.
- `packs/obsidian-second-brain/skills/obsidian-capture/references/capture-workflow.md`
  General capture workflow. Add the compact OCR book body shape and new status fields.
- `packs/obsidian-second-brain/skills/obsidian-retrieve/SKILL.md`
  Main retrieval safety rule. Add index-only and weak OCR behavior.
- `packs/obsidian-second-brain/skills/obsidian-retrieve/references/retrieve-workflow.md`
  Detailed retrieval search and evidence workflow.
- `packs/obsidian-second-brain/skills/obsidian-lint/SKILL.md`
  Main lint trigger and report sections for OCR book health.
- `packs/obsidian-second-brain/skills/obsidian-lint/references/lint-workflow.md`
  Detailed lint checks for OCR book index/chunk quality.
- `packs/obsidian-second-brain/tools/verify-second-brain-skills.sh`
  Pack-level verification for new templates and required rule text.
- `packs/obsidian-second-brain/tools/verify-vault.sh`
  Vault-level verification already requires `20_Sources/books/raw`; add template content checks.
- `packs/obsidian-second-brain/README.md`
  User-facing OCR book capture usage.

No new executable PDF parser is created in this plan.

## Task 1: Strengthen Book OCR Template Fields

**Files:**
- Modify: `packs/obsidian-second-brain/shared/obsidian-second-brain/templates/book-ocr-source.md`
- Modify: `packs/obsidian-second-brain/vault-template/00_System/templates/book-ocr-source.md`

- [ ] **Step 1: Update frontmatter in the shared template**

In `packs/obsidian-second-brain/shared/obsidian-second-brain/templates/book-ocr-source.md`, replace the current frontmatter with:

```yaml
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
```

- [ ] **Step 2: Replace the shared template body with the quality-gated shape**

In the same file, replace the body after frontmatter with:

```markdown
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
```

- [ ] **Step 3: Copy the same final content to the vault template**

Make `packs/obsidian-second-brain/vault-template/00_System/templates/book-ocr-source.md` exactly match the shared template.

Run:

```bash
diff -u packs/obsidian-second-brain/shared/obsidian-second-brain/templates/book-ocr-source.md packs/obsidian-second-brain/vault-template/00_System/templates/book-ocr-source.md
```

Expected: no output.

- [ ] **Step 4: Verify template fields are present**

Run:

```bash
rg -n "chunking_strategy|chunk_quality|retrieval_ready|evidence_level|needs_rechunk" packs/obsidian-second-brain/shared/obsidian-second-brain/templates/book-ocr-source.md packs/obsidian-second-brain/vault-template/00_System/templates/book-ocr-source.md
```

Expected: matches in both template files.

- [ ] **Step 5: Commit Task 1**

```bash
git add packs/obsidian-second-brain/shared/obsidian-second-brain/templates/book-ocr-source.md packs/obsidian-second-brain/vault-template/00_System/templates/book-ocr-source.md
git commit -m "Strengthen OCR book source template"
```

## Task 2: Expand OCR Book Workflow Rules

**Files:**
- Modify: `packs/obsidian-second-brain/skills/obsidian-capture/references/book-ocr-workflow.md`
- Modify: `packs/obsidian-second-brain/skills/obsidian-capture/references/capture-workflow.md`

- [ ] **Step 1: Add Book Index rules to `book-ocr-workflow.md`**

In `packs/obsidian-second-brain/skills/obsidian-capture/references/book-ocr-workflow.md`, after `## Capture Strategy`, add:

```markdown
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
```

- [ ] **Step 2: Add Chunk Boundary Policy to `book-ocr-workflow.md`**

After the Book Index rules, add:

```markdown
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
```

- [ ] **Step 3: Add Retrieval Safety handoff to `book-ocr-workflow.md`**

After `## Compile Handoff`, add:

```markdown
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
```

- [ ] **Step 4: Update the general OCR book body structure in `capture-workflow.md`**

In `packs/obsidian-second-brain/skills/obsidian-capture/references/capture-workflow.md`, under `## OCR Book Body Structure`, add these fields to the sample:

```markdown
## Chunking Plan

- chunking_strategy: toc | heading | page_range | semantic | manual
- chunk_unit: chapter | section | claim | page_range
- chunk_quality: good | uneven | too_large | uncertain
- rechunk_candidates: []

## Retrieval Safety

- retrieval_ready: yes | partial | no
- evidence_level: source_verified | index_only | weak_ocr | needs_review
- answer_scope: book | chapter | section | claim
```

Place `## Chunking Plan` after `## OCR Basis`. Place `## Retrieval Safety` before `## Processing Notes`.

- [ ] **Step 5: Verify workflow text**

Run:

```bash
rg -n "Book Index is a routing note|Chunk Boundary Policy|Retrieval Safety Handoff|retrieval_ready|evidence_level|needs_rechunk" packs/obsidian-second-brain/skills/obsidian-capture/references/book-ocr-workflow.md packs/obsidian-second-brain/skills/obsidian-capture/references/capture-workflow.md
```

Expected: matches for all rule names and status fields.

- [ ] **Step 6: Commit Task 2**

```bash
git add packs/obsidian-second-brain/skills/obsidian-capture/references/book-ocr-workflow.md packs/obsidian-second-brain/skills/obsidian-capture/references/capture-workflow.md
git commit -m "Document OCR book chunking quality rules"
```

## Task 3: Update Capture Skill Safety Rules

**Files:**
- Modify: `packs/obsidian-second-brain/skills/obsidian-capture/SKILL.md`
- Modify: `packs/obsidian-second-brain/README.md`

- [ ] **Step 1: Strengthen OCR book workflow bullets in `SKILL.md`**

In `packs/obsidian-second-brain/skills/obsidian-capture/SKILL.md`, inside the OCR books workflow block, add these bullets:

```markdown
   - Treat the Book Index as a routing note, not final answer evidence.
   - Add `chunking_strategy`, `chunk_unit`, `chunk_quality`, `retrieval_ready`, and `evidence_level` when creating OCR book notes.
   - If chunk Source notes do not exist yet, use `retrieval_ready: partial` or `retrieval_ready: no`.
   - If a chunk is too large or mixes multiple claims, set `chunk_quality: too_large` and `status: needs_rechunk`.
```

- [ ] **Step 2: Strengthen OCR Book Capture Requirements in `SKILL.md`**

In the `## OCR Book Capture Requirements` section, add:

```markdown
- `## Chunking Plan`: strategy, unit, quality, and rechunk candidates.
- `## Retrieval Safety`: retrieval readiness, evidence level, and answer scope.

Book Index notes are not sufficient answer evidence. They should point to chunk Source notes. Use `retrieval_ready: no` or `retrieval_ready: partial` until chunk Source notes and source locations exist.
```

- [ ] **Step 3: Add new status values in `SKILL.md` Safety**

In `## Safety`, add:

```markdown
- If chunk boundaries are too broad or mixed, use `needs_rechunk`.
- Do not promote index-only content into strong Claim or Insight notes.
- Do not mark OCR book material as `retrieval_ready: yes` unless chunk Source notes and source locations exist.
```

- [ ] **Step 4: Update README OCR book usage**

In `packs/obsidian-second-brain/README.md`, update the OCR book usage block to include this instruction:

```text
책 index는 요약문이 아니라 탐색 지도로 만들어줘.
chunking_strategy, chunk_quality, retrieval_ready, evidence_level을 남기고,
chunk가 없으면 index만 보고 답하지 않도록 표시해줘.
```

- [ ] **Step 5: Verify capture-facing text**

Run:

```bash
rg -n "routing note|chunking_strategy|chunk_quality|retrieval_ready|evidence_level|needs_rechunk|index-only" packs/obsidian-second-brain/skills/obsidian-capture/SKILL.md packs/obsidian-second-brain/README.md
```

Expected: matches in `SKILL.md` and README.

- [ ] **Step 6: Commit Task 3**

```bash
git add packs/obsidian-second-brain/skills/obsidian-capture/SKILL.md packs/obsidian-second-brain/README.md
git commit -m "Add OCR book capture quality gates"
```

## Task 4: Add Retrieval Safety Rules

**Files:**
- Modify: `packs/obsidian-second-brain/skills/obsidian-retrieve/SKILL.md`
- Modify: `packs/obsidian-second-brain/skills/obsidian-retrieve/references/retrieve-workflow.md`

- [ ] **Step 1: Add OCR book retrieval workflow steps in `SKILL.md`**

In `packs/obsidian-second-brain/skills/obsidian-retrieve/SKILL.md`, after the existing workflow list, add:

```markdown
## OCR Book Retrieval

When a question touches OCR book material:

1. Use Book Index notes only to find candidate chunk Source notes.
2. Open the related Chapter or Section Source before answering.
3. Check `retrieval_ready`, `evidence_level`, `ocr_quality`, and `chunk_quality`.
4. If evidence is `index_only`, answer narrowly and state that chunk evidence is missing.
5. If evidence is `weak_ocr` or `needs_review`, lower confidence and state the OCR limitation.
6. If `chunk_quality: too_large`, suggest rechunking or ask for a narrower scope before making detailed claims.
```

- [ ] **Step 2: Add OCR book answer format fields in `SKILL.md`**

In `## Answer Format`, add these lines under `## Evidence` or `## Confidence`:

```markdown
## Evidence Level

source_verified | index_only | weak_ocr | needs_review

## Answer Scope

book | chapter | section | claim
```

- [ ] **Step 3: Add safety bullets in `SKILL.md`**

In `## Safety`, add:

```markdown
- Do not answer from Book Index alone when chunk Source notes are required.
- Do not treat `needs_ocr_review` material as high-confidence evidence.
- If `retrieval_ready` is `partial` or `no`, state what evidence is missing.
```

- [ ] **Step 4: Expand `retrieve-workflow.md` evidence rules**

In `packs/obsidian-second-brain/skills/obsidian-retrieve/references/retrieve-workflow.md`, under `## Evidence Rules`, add:

```markdown
## OCR Book Evidence Rules

- Book Index notes route retrieval; they do not settle answers.
- Prefer chunk Source notes with page, chapter, or heading anchors.
- Use `evidence_level: source_verified` only when the answer points to a chunk Source and raw location.
- Use `evidence_level: index_only` when only Book Index metadata exists.
- Use `evidence_level: weak_ocr` when OCR quality or page boundaries are weak.
- Use `evidence_level: needs_review` when human review is needed before strong claims.
```

- [ ] **Step 5: Verify retrieval rules**

Run:

```bash
rg -n "OCR Book Retrieval|Evidence Level|index_only|weak_ocr|retrieval_ready|Book Index notes route retrieval" packs/obsidian-second-brain/skills/obsidian-retrieve/SKILL.md packs/obsidian-second-brain/skills/obsidian-retrieve/references/retrieve-workflow.md
```

Expected: matches in both retrieval files.

- [ ] **Step 6: Commit Task 4**

```bash
git add packs/obsidian-second-brain/skills/obsidian-retrieve/SKILL.md packs/obsidian-second-brain/skills/obsidian-retrieve/references/retrieve-workflow.md
git commit -m "Add OCR book retrieval safety rules"
```

## Task 5: Add OCR Book Lint Checks

**Files:**
- Modify: `packs/obsidian-second-brain/skills/obsidian-lint/SKILL.md`
- Modify: `packs/obsidian-second-brain/skills/obsidian-lint/references/lint-workflow.md`

- [ ] **Step 1: Add OCR book lint workflow item in `SKILL.md`**

In `packs/obsidian-second-brain/skills/obsidian-lint/SKILL.md`, add this workflow step before creating the report:

```markdown
8. Find OCR book quality issues:
   - Book Index notes that became long summaries.
   - `retrieval_ready: yes` without chunk Source links.
   - `chunk_quality: too_large` with compiled objects.
   - Claim or Insight notes without source location links.
   - `needs_ocr_review` notes with no next review action.
```

Renumber the following report and dashboard steps so the workflow remains sequential.

- [ ] **Step 2: Add report section in `SKILL.md`**

In `## Report Sections`, add:

```markdown
- OCR book quality issues
```

- [ ] **Step 3: Add OCR book lint checks in `lint-workflow.md`**

In `packs/obsidian-second-brain/skills/obsidian-lint/references/lint-workflow.md`, after `### Missing Evidence`, add:

```markdown
### OCR Book Quality Issues

Book OCR material that can lower retrieval quality.

Flag:

- Book Index notes with long whole-book summaries.
- Book Index notes with `retrieval_ready: yes` and no chunk Source links.
- Chunk Source notes with `chunk_quality: too_large` that already produced Concept, Claim, or Insight notes.
- Claim or Insight notes derived from OCR books without page, chapter, heading, or chunk links.
- Notes marked `needs_ocr_review` without a next review action.
```

- [ ] **Step 4: Add report format section in `lint-workflow.md`**

In the lint report format code block, add this section before `## Broken Links`:

```markdown
## OCR Book Quality Issues

- [[note]]: issue and suggested review action
```

- [ ] **Step 5: Verify lint rules**

Run:

```bash
rg -n "OCR book quality issues|OCR Book Quality Issues|retrieval_ready: yes|chunk_quality: too_large|needs_ocr_review" packs/obsidian-second-brain/skills/obsidian-lint/SKILL.md packs/obsidian-second-brain/skills/obsidian-lint/references/lint-workflow.md
```

Expected: matches in both lint files.

- [ ] **Step 6: Commit Task 5**

```bash
git add packs/obsidian-second-brain/skills/obsidian-lint/SKILL.md packs/obsidian-second-brain/skills/obsidian-lint/references/lint-workflow.md
git commit -m "Add OCR book lint checks"
```

## Task 6: Update Verification Scripts

**Files:**
- Modify: `packs/obsidian-second-brain/tools/verify-second-brain-skills.sh`
- Modify: `packs/obsidian-second-brain/tools/verify-vault.sh`

- [ ] **Step 1: Add required grep checks to pack verification**

In `packs/obsidian-second-brain/tools/verify-second-brain-skills.sh`, after the existing OCR book grep checks, add:

```bash
grep -R "chunking_strategy" shared/obsidian-second-brain/templates/book-ocr-source.md >/dev/null
grep -R "chunk_quality" vault-template/00_System/templates/book-ocr-source.md >/dev/null
grep -R "retrieval_ready" shared/obsidian-second-brain/templates/book-ocr-source.md >/dev/null
grep -R "evidence_level" vault-template/00_System/templates/book-ocr-source.md >/dev/null
grep -R "Chunk Boundary Policy" skills/obsidian-capture/references/book-ocr-workflow.md >/dev/null
grep -R "Retrieval Safety Handoff" skills/obsidian-capture/references/book-ocr-workflow.md >/dev/null
grep -R "index_only" skills/obsidian-retrieve/SKILL.md >/dev/null
grep -R "weak_ocr" skills/obsidian-retrieve/references/retrieve-workflow.md >/dev/null
grep -R "OCR Book Quality Issues" skills/obsidian-lint/references/lint-workflow.md >/dev/null
```

- [ ] **Step 2: Add template content checks to vault verification**

In `packs/obsidian-second-brain/tools/verify-vault.sh`, after the existing template content checks, add:

```bash
if [[ -f "$vault_root/00_System/templates/book-ocr-source.md" ]] &&
  ! grep -R "chunking_strategy" "$vault_root/00_System/templates/book-ocr-source.md" >/dev/null; then
  missing+=("content: 00_System/templates/book-ocr-source.md lacks chunking_strategy")
fi

if [[ -f "$vault_root/00_System/templates/book-ocr-source.md" ]] &&
  ! grep -R "retrieval_ready" "$vault_root/00_System/templates/book-ocr-source.md" >/dev/null; then
  missing+=("content: 00_System/templates/book-ocr-source.md lacks retrieval_ready")
fi
```

- [ ] **Step 3: Run pack verification**

Run:

```bash
packs/obsidian-second-brain/tools/verify-second-brain-skills.sh
```

Expected:

```text
Second brain skill pack verification passed.
```

- [ ] **Step 4: Run repo verification**

Run:

```bash
./tools/verify-skill-repo.sh
```

Expected:

```text
Second brain skill pack verification passed.
Codex skill repository verification passed.
```

- [ ] **Step 5: Commit Task 6**

```bash
git add packs/obsidian-second-brain/tools/verify-second-brain-skills.sh packs/obsidian-second-brain/tools/verify-vault.sh
git commit -m "Verify OCR book quality rules"
```

## Task 7: Update Existing 2ndMe Vault Template

**Files:**
- Runtime target: `/Users/picpal/Library/Mobile Documents/iCloud~md~obsidian/Documents/2ndMe/00_System/templates/book-ocr-source.md`

- [ ] **Step 1: Re-run non-destructive vault init**

Run:

```bash
packs/obsidian-second-brain/tools/init-second-brain-vault.sh "/Users/picpal/Library/Mobile Documents/iCloud~md~obsidian/Documents/2ndMe"
```

Expected output includes:

```text
Initialized Obsidian second brain vault.
Existing files kept:
```

If the existing `book-ocr-source.md` file is kept, update that vault template manually from `packs/obsidian-second-brain/vault-template/00_System/templates/book-ocr-source.md` only after confirming the existing file is the pack-managed template and not a user-customized version.

- [ ] **Step 2: Verify the 2ndMe vault**

Run:

```bash
packs/obsidian-second-brain/tools/verify-vault.sh "/Users/picpal/Library/Mobile Documents/iCloud~md~obsidian/Documents/2ndMe"
```

Expected:

```text
Obsidian second brain vault verification passed.
```

- [ ] **Step 3: Do not commit vault files**

The 2ndMe vault is outside this repository. No `git add` is needed for runtime vault files.

## Task 8: Final Verification and Branch State

**Files:**
- No direct file edits.

- [ ] **Step 1: Run final pack verification**

Run:

```bash
packs/obsidian-second-brain/tools/verify-second-brain-skills.sh
```

Expected:

```text
Second brain skill pack verification passed.
```

- [ ] **Step 2: Run final repo verification**

Run:

```bash
./tools/verify-skill-repo.sh
```

Expected:

```text
Second brain skill pack verification passed.
Codex skill repository verification passed.
```

- [ ] **Step 3: Inspect git status**

Run:

```bash
git status --short --branch
```

Expected: no unstaged or uncommitted repository changes after task commits.

- [ ] **Step 4: Summarize implementation**

Report:

- Template fields added.
- Capture workflow safety rules added.
- Retrieve index-only safeguards added.
- Lint OCR book quality checks added.
- Verification commands and results.

Do not claim completion unless the verification commands above have just passed.

## Self-Review

Spec coverage:

- Raw PDF preservation: Task 3 and existing `20_Sources/books/raw/` verification in Task 6.
- Thin Book Index: Task 1 and Task 2.
- Chunk Boundary Policy: Task 2.
- Retrieval Safety Rule: Task 4.
- Lint quality checks: Task 5.
- Verification script updates: Task 6.
- Existing vault update: Task 7.

No intentionally skipped spec requirement remains inside the documented scope. PDF parsing, vector search, and batch import remain outside scope by design.
