# Obsidian Second Brain Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a reusable Obsidian second-brain skill pack that provides a vault template, note templates, and four Codex/Claude Code skills for capture, compile, retrieve, and lint workflows.

**Architecture:** Create a shared vault template and reference layer first, then create four focused skills that all point to the same memory model. The skills are documentation-driven workflows, not autonomous daemons: they instruct agents how to write, update, retrieve, and validate Obsidian notes while preserving source evidence and user trust.

**Tech Stack:** Markdown, Obsidian Flavored Markdown, Codex skill `SKILL.md` format, shell-based structure verification, git.

---

## Target File Structure

Create this structure under `/Users/picpal/Desktop/workspace/skills`:

```text
README.md

shared/obsidian-second-brain/
  README.md
  references/
    vault-structure.md
    note-types.md
    workflows.md
    reliability.md
  templates/
    source.md
    concept.md
    claim.md
    question.md
    insight.md
    map.md
    project.md
    decision.md
    daily-review.md
    weekly-review.md
    home-dashboard.md

vault-template/
  00_System/
    dashboards/Home.md
    logs/.gitkeep
    schemas/note-types.md
    templates/source.md
    templates/concept.md
    templates/claim.md
    templates/question.md
    templates/insight.md
    templates/map.md
    templates/project.md
    templates/decision.md
    templates/daily-review.md
    templates/weekly-review.md
    lint/.gitkeep
  10_Capture/
    inbox/.gitkeep
    quick-notes/.gitkeep
    unprocessed/.gitkeep
    attachments-staging/.gitkeep
  20_Sources/
    sessions/.gitkeep
    web/.gitkeep
    videos/.gitkeep
    images/.gitkeep
    documents/.gitkeep
    books/.gitkeep
    papers/.gitkeep
  30_Objects/
    concepts/.gitkeep
    people/.gitkeep
    claims/.gitkeep
    questions/.gitkeep
    insights/.gitkeep
    decisions/.gitkeep
    methods/.gitkeep
  40_Maps/
    topic-maps/.gitkeep
    project-maps/.gitkeep
    research-maps/.gitkeep
    index-notes/.gitkeep
  50_Execution/
    projects/.gitkeep
    plans/.gitkeep
    decisions/.gitkeep
    outputs/.gitkeep
    retrospectives/.gitkeep
  60_Reviews/
    daily/.gitkeep
    weekly/.gitkeep
    monthly/.gitkeep
    lint-reports/.gitkeep
    synthesis-reports/.gitkeep
  90_Archive/
    inactive/.gitkeep
    superseded/.gitkeep
    deprecated/.gitkeep
    old-outputs/.gitkeep
  _assets/
    images/.gitkeep
    files/.gitkeep
    exports/.gitkeep
    thumbnails/.gitkeep

obsidian-capture/
  SKILL.md
  references/capture-workflow.md

obsidian-compile/
  SKILL.md
  references/compile-workflow.md

obsidian-retrieve/
  SKILL.md
  references/retrieve-workflow.md

obsidian-lint/
  SKILL.md
  references/lint-workflow.md

tools/
  verify-second-brain-skills.sh
```

## Implementation Tasks

### Task 1: Repository Hygiene and Root README

**Files:**
- Modify: `/Users/picpal/Desktop/workspace/skills/.gitignore`
- Create: `/Users/picpal/Desktop/workspace/skills/README.md`

- [ ] **Step 1: Update `.gitignore`**

Add macOS and visual companion noise to `.gitignore`:

```gitignore
.DS_Store
**/.DS_Store
.superpowers/
```

- [ ] **Step 2: Create root `README.md`**

Create `/Users/picpal/Desktop/workspace/skills/README.md`:

```markdown
# Obsidian Second Brain Skills

This repository contains an Obsidian second-brain skill pack for Codex and Claude Code.

The system is designed around one principle:

> Capture freely, preserve sources, compile knowledge, surface insights, and connect insights to execution.

## Contents

- `vault-template/`: starter Obsidian vault structure.
- `shared/obsidian-second-brain/`: shared references and note templates.
- `obsidian-capture/`: skill for frictionless raw input capture.
- `obsidian-compile/`: skill for turning sources into linked memory.
- `obsidian-retrieve/`: skill for answering questions from the vault.
- `obsidian-lint/`: skill for memory health checks and review reports.

## Workflow

1. Capture raw material or freeform thoughts.
2. Preserve the source and metadata.
3. Compile into objects, maps, insights, projects, and decisions.
4. Retrieve from maps and sources with evidence links.
5. Lint the vault to find stale claims, weak evidence, duplicate notes, and missed links.
```

- [ ] **Step 3: Verify root files**

Run:

```bash
test -f README.md
test -f .gitignore
rg -n "Capture freely|vault-template|obsidian-capture" README.md
rg -n "\\.DS_Store|\\.superpowers/" .gitignore
```

Expected: all commands exit successfully and print matching lines for the `rg` commands.

- [ ] **Step 4: Commit**

```bash
git add .gitignore README.md
git commit -m "docs: add second brain repository overview"
```

### Task 2: Shared References

**Files:**
- Create: `/Users/picpal/Desktop/workspace/skills/shared/obsidian-second-brain/README.md`
- Create: `/Users/picpal/Desktop/workspace/skills/shared/obsidian-second-brain/references/vault-structure.md`
- Create: `/Users/picpal/Desktop/workspace/skills/shared/obsidian-second-brain/references/note-types.md`
- Create: `/Users/picpal/Desktop/workspace/skills/shared/obsidian-second-brain/references/workflows.md`
- Create: `/Users/picpal/Desktop/workspace/skills/shared/obsidian-second-brain/references/reliability.md`

- [ ] **Step 1: Create shared package README**

Create `shared/obsidian-second-brain/README.md`:

```markdown
# Shared Obsidian Second Brain References

This folder contains the shared memory model used by all four skills:

- `vault-structure.md`: canonical folder layout.
- `note-types.md`: note object model and required fields.
- `workflows.md`: capture, compile, retrieve, lint flow.
- `reliability.md`: source preservation, confidence, ambiguity, and conflict rules.
- `templates/`: reusable Obsidian note templates.

Skills should cite these references instead of redefining the system from memory.
```

- [ ] **Step 2: Create `vault-structure.md`**

Create `shared/obsidian-second-brain/references/vault-structure.md`:

```markdown
# Vault Structure

The vault is a compiled wiki plus execution layer.

## Folders

- `00_System`: dashboards, logs, schemas, templates, lint rules.
- `10_Capture`: inbox, quick notes, unprocessed input, staging attachments.
- `20_Sources`: preserved source notes for sessions, web, videos, images, documents, books, and papers.
- `30_Objects`: concepts, people, claims, questions, insights, decisions, methods.
- `40_Maps`: topic maps, project maps, research maps, index notes.
- `50_Execution`: projects, plans, decisions, outputs, retrospectives.
- `60_Reviews`: daily, weekly, monthly, lint reports, synthesis reports.
- `90_Archive`: inactive, superseded, deprecated, old outputs.
- `_assets`: images, files, exports, thumbnails.

## Folder Responsibilities

Folders organize workflow. Links organize meaning. Do not rely on folder location alone to express relationships.
```

- [ ] **Step 3: Create `note-types.md`**

Create `shared/obsidian-second-brain/references/note-types.md`:

```markdown
# Note Types

## Source

Purpose: preserve original material or a pointer to it.
Required fields: `type`, `created`, `source_type`, `status`, `confidence`, `related_maps`, `related_objects`, `related_projects`.

## Concept

Purpose: define a reusable idea.
Required fields: definition, examples, contrasts, source links, related questions, claims, insights.

## Claim

Purpose: track a testable or debatable statement.
Required fields: claim, evidence, counter-evidence, confidence, source links, review date.

## Question

Purpose: preserve unresolved inquiry.
Required fields: question, current hypothesis, why it matters, related sources, next exploration step.

## Insight

Purpose: record a meaningful new connection or perspective change.
Required fields: trigger, new connection, change, evidence, implication, next action, related project, review date.

## Map

Purpose: show the terrain of a topic, research area, or project.
Required fields: current summary, key linked objects, important sources, open questions, tensions, related projects, latest synthesis.

## Project

Purpose: connect research and insight to execution.
Required fields: objective, status, related maps, key decisions, next actions, outputs, retrospectives.

## Decision

Purpose: record a choice and its reasoning.
Required fields: decision, options considered, evidence, trade-offs, rejected alternatives, expected outcome, review condition.
```

- [ ] **Step 4: Create `workflows.md`**

Create `shared/obsidian-second-brain/references/workflows.md`:

```markdown
# Workflows

## Capture Flow

1. Accept raw input without requiring classification.
2. Preserve original content or source pointer.
3. Add metadata: date, source type, status, confidence.
4. Store in `10_Capture` or `20_Sources`.

## Compile Flow

1. Read the captured item.
2. Compare against existing maps, objects, projects, and decisions.
3. Prefer updating existing notes before creating new notes.
4. Create insight candidates only when a meaningful new connection appears.
5. Update maps and dashboard surfaces.
6. Log changed notes.

## Retrieve Flow

1. Start from relevant maps.
2. Follow links to object notes.
3. Open source notes for evidence.
4. Distinguish evidence from inference.
5. Save new insight, question, decision, or output candidates when retrieval creates value.

## Lint Flow

1. Find orphan notes, duplicate concepts, weak claims, stale decisions, and broken links.
2. Produce review items, not silent rewrites.
3. Add lint reports to `60_Reviews/lint-reports`.
4. Surface important review items on the Home dashboard.
```

- [ ] **Step 5: Create `reliability.md`**

Create `shared/obsidian-second-brain/references/reliability.md`:

```markdown
# Reliability Rules

## Source Preservation

Do not overwrite original source content. Add interpretation, summary, processing status, and links separately.

## Confidence

Use `low`, `medium`, or `high`.

- `low`: plausible but weakly supported.
- `medium`: supported by one or more sources but not deeply checked.
- `high`: supported by strong evidence or repeated confirmation.

## Ambiguity

Preserve ambiguous material as `unprocessed`, `hypothesis`, `question`, `needs_classification`, or `needs_evidence`.

## Conflict

When new material conflicts with an existing note, create a tension or contradiction entry. Link both sides. Add a review date.

## Merge Before Create

Before creating a new object note, search for existing candidates and prefer update or merge when appropriate.
```

- [ ] **Step 6: Verify shared references**

Run:

```bash
test -f shared/obsidian-second-brain/README.md
test -f shared/obsidian-second-brain/references/vault-structure.md
test -f shared/obsidian-second-brain/references/note-types.md
test -f shared/obsidian-second-brain/references/workflows.md
test -f shared/obsidian-second-brain/references/reliability.md
rg -n "Compiled|Capture Flow|Merge Before Create|Insight" shared/obsidian-second-brain
```

Expected: all files exist; `rg` prints matches in the shared references.

- [ ] **Step 7: Commit**

```bash
git add shared/obsidian-second-brain
git commit -m "docs: add shared second brain references"
```

### Task 3: Note Templates and Vault Template

**Files:**
- Create: `/Users/picpal/Desktop/workspace/skills/shared/obsidian-second-brain/templates/*.md`
- Create: `/Users/picpal/Desktop/workspace/skills/vault-template/**`

- [ ] **Step 1: Create shared note templates**

Create the following files in `shared/obsidian-second-brain/templates/`.

`source.md`:

```markdown
---
type: source
created: "{{date}}"
source_type: "{{source_type}}"
status: captured
confidence: medium
related_maps: []
related_objects: []
related_projects: []
---

# {{title}}

## Original

{{original_or_pointer}}

## Summary

{{summary}}

## Key Evidence

- {{evidence_item}}

## Processing Notes

- Status: captured
- Next step: compile into objects and maps
```

`concept.md`:

```markdown
---
type: concept
created: "{{date}}"
status: active
confidence: medium
related_sources: []
related_questions: []
related_claims: []
related_insights: []
---

# {{concept}}

## Definition

{{definition}}

## Examples

- {{example}}

## Contrasts

- {{contrast}}

## Links

- Sources:
- Questions:
- Claims:
- Insights:
```

`claim.md`:

```markdown
---
type: claim
created: "{{date}}"
status: active
confidence: low
review_date: "{{review_date}}"
related_sources: []
related_concepts: []
---

# {{claim}}

## Claim

{{claim_statement}}

## Evidence

- {{evidence}}

## Counter-Evidence

- {{counter_evidence}}

## Uncertainty

{{uncertainty}}
```

`question.md`:

```markdown
---
type: question
created: "{{date}}"
status: open
confidence: low
related_sources: []
related_concepts: []
related_projects: []
---

# {{question}}

## Question

{{question}}

## Current Hypothesis

{{hypothesis}}

## Why It Matters

{{why_it_matters}}

## Next Exploration

- {{next_step}}
```

`insight.md`:

```markdown
---
type: insight
created: "{{date}}"
status: active
confidence: medium
review_date: "{{review_date}}"
related_sources: []
related_objects: []
related_projects: []
---

# {{insight_title}}

## Trigger

{{trigger}}

## New Connection

{{new_connection}}

## Change In Thinking

{{change}}

## Evidence

- {{evidence}}

## Implication

{{implication}}

## Next Action

- {{next_action}}
```

`map.md`:

```markdown
---
type: map
created: "{{date}}"
status: active
related_sources: []
related_objects: []
related_projects: []
---

# {{map_title}}

## Current Summary

{{summary}}

## Key Objects

- {{object_link}}

## Important Sources

- {{source_link}}

## Open Questions

- {{question_link}}

## Tensions

- {{tension}}

## Latest Synthesis

{{synthesis}}
```

`project.md`:

```markdown
---
type: project
created: "{{date}}"
status: active
related_maps: []
related_decisions: []
related_insights: []
---

# {{project_name}}

## Objective

{{objective}}

## Status

{{status}}

## Research Links

- {{map_or_source}}

## Key Decisions

- {{decision_link}}

## Next Actions

- {{next_action}}

## Outputs

- {{output_link}}
```

`decision.md`:

```markdown
---
type: decision
created: "{{date}}"
status: active
confidence: medium
review_date: "{{review_date}}"
related_sources: []
related_projects: []
---

# {{decision_title}}

## Decision

{{decision}}

## Options Considered

- {{option}}

## Evidence

- {{source_link}}

## Trade-Offs

- {{tradeoff}}

## Rejected Alternatives

- {{rejected_alternative}}

## Expected Outcome

{{expected_outcome}}

## Review Condition

{{review_condition}}
```

`daily-review.md`:

```markdown
---
type: daily_review
created: "{{date}}"
---

# Daily Review - {{date}}

## New Inputs

- {{input}}

## New Insights

- {{insight}}

## Tomorrow's Question Or Action

- {{next_focus}}
```

`weekly-review.md`:

```markdown
---
type: weekly_review
created: "{{date}}"
---

# Weekly Review - {{date}}

## Repeated Themes

- {{theme}}

## Promoted Insights

- {{insight}}

## Project Or Decision Transfers

- {{transfer}}

## Lint Items

- {{lint_item}}

## Next Research Direction

- {{direction}}
```

`home-dashboard.md`:

```markdown
---
type: dashboard
created: "{{date}}"
---

# Home Dashboard

## Worth Reading Now

- {{insight}}

## Repeated Themes

- {{theme}}

## New Connections

- {{connection}}

## Open Questions

- {{question}}

## Tensions And Contradictions

- {{tension}}

## Decision Candidates

- {{decision_candidate}}

## Project Opportunities

- {{project_opportunity}}

## Next Actions

- {{next_action}}

## Review Items

- {{review_item}}
```

- [ ] **Step 2: Create vault directory tree**

Create every directory listed in the target file structure under `vault-template/`. Put `.gitkeep` into every empty leaf directory.

- [ ] **Step 3: Copy templates into `vault-template/00_System/templates`**

Copy the 11 files from `shared/obsidian-second-brain/templates/` into `vault-template/00_System/templates/`.

- [ ] **Step 4: Create `vault-template/00_System/dashboards/Home.md`**

Use the same content as `shared/obsidian-second-brain/templates/home-dashboard.md`, but replace `{{date}}` with `2026-05-15`.

- [ ] **Step 5: Create `vault-template/00_System/schemas/note-types.md`**

Copy the content of `shared/obsidian-second-brain/references/note-types.md` into this file.

- [ ] **Step 6: Verify templates and vault structure**

Run:

```bash
test -f shared/obsidian-second-brain/templates/source.md
test -f shared/obsidian-second-brain/templates/insight.md
test -f vault-template/00_System/dashboards/Home.md
test -f vault-template/00_System/templates/decision.md
test -d vault-template/20_Sources/web
test -d vault-template/30_Objects/insights
test -d vault-template/60_Reviews/synthesis-reports
rg -n "type: insight|New Connection|Decision Candidates|Review Items" shared/obsidian-second-brain/templates vault-template/00_System
```

Expected: all paths exist; `rg` prints template fields and dashboard sections.

- [ ] **Step 7: Commit**

```bash
git add shared/obsidian-second-brain/templates vault-template
git commit -m "feat: add Obsidian vault template"
```

### Task 4: `obsidian-capture` Skill

**Files:**
- Create: `/Users/picpal/Desktop/workspace/skills/obsidian-capture/SKILL.md`
- Create: `/Users/picpal/Desktop/workspace/skills/obsidian-capture/references/capture-workflow.md`

- [ ] **Step 1: Create `obsidian-capture/SKILL.md`**

```markdown
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
```

- [ ] **Step 2: Create `capture-workflow.md`**

```markdown
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
```

- [ ] **Step 3: Verify capture skill**

Run:

```bash
test -f obsidian-capture/SKILL.md
test -f obsidian-capture/references/capture-workflow.md
rg -n "low-friction|needs_classification|Never overwrite|obsidian-compile" obsidian-capture
```

Expected: skill and workflow files exist; required capture rules are present.

- [ ] **Step 4: Commit**

```bash
git add obsidian-capture
git commit -m "feat: add Obsidian capture skill"
```

### Task 5: `obsidian-compile` Skill

**Files:**
- Create: `/Users/picpal/Desktop/workspace/skills/obsidian-compile/SKILL.md`
- Create: `/Users/picpal/Desktop/workspace/skills/obsidian-compile/references/compile-workflow.md`

- [ ] **Step 1: Create `obsidian-compile/SKILL.md`**

```markdown
---
name: obsidian-compile
description: Transform captured Obsidian sources and thoughts into linked concepts, claims, questions, insights, maps, projects, and decisions.
---

# Obsidian Compile

Use this skill when captured material should be compared with existing vault knowledge and turned into linked memory.

## Core Rule

Prefer updating existing notes before creating new notes. Create an Insight only when there is a meaningful new connection, contradiction, pattern, or execution implication.

## Workflow

1. Locate captured or source notes to process.
2. Read relevant maps and existing object notes before writing.
3. Identify candidate note types:
   - Concept
   - Claim
   - Question
   - Insight
   - Map
   - Project
   - Decision
4. Search for merge or update candidates.
5. Update existing notes when suitable.
6. Create new object notes only when needed.
7. Update related maps and the Home dashboard.
8. Add log entries in `00_System/logs`.

## Insight Promotion

Promote to Insight when:

- Two or more existing notes become newly connected.
- New evidence changes or challenges a prior belief.
- A repeated pattern becomes visible.
- A question becomes an actionable hypothesis.
- A source changes the direction of a project or decision.

## Safety

- Do not silently overwrite existing conclusions.
- Preserve uncertainty.
- Link evidence to Source notes.
- Mark weak claims as `hypothesis` or `question`, not confident `claim`.

## References

- `../shared/obsidian-second-brain/references/workflows.md`
- `../shared/obsidian-second-brain/references/reliability.md`
- `references/compile-workflow.md`
```

- [ ] **Step 2: Create `compile-workflow.md`**

```markdown
# Compile Workflow

## Processing Steps

1. Read the captured Source note.
2. Extract candidate concepts, claims, questions, tensions, and execution implications.
3. Search `30_Objects` and `40_Maps` for existing related notes.
4. Decide for each candidate:
   - update existing note
   - create new note
   - keep as unresolved
   - mark as hypothesis
5. Update or create notes using templates from `shared/obsidian-second-brain/templates`.
6. Update the most relevant Map.
7. Update Dashboard sections when there are visible insights, tensions, decisions, or next actions.
8. Write a log entry.

## Log Entry Format

```markdown
## {{date}} Compile

- Source processed: [[source-note]]
- Updated notes:
  - [[note]]
- Created notes:
  - [[note]]
- Insight candidates:
  - [[insight]]
- Unresolved:
  - {{question_or_issue}}
```

## Merge Before Create Checklist

- Search exact title.
- Search aliases and near synonyms.
- Check relevant maps.
- Check recent insights.
- If a similar note exists, update it and add the source link.
```

- [ ] **Step 3: Verify compile skill**

Run:

```bash
test -f obsidian-compile/SKILL.md
test -f obsidian-compile/references/compile-workflow.md
rg -n "Prefer updating existing notes|Insight Promotion|Merge Before Create|Home dashboard" obsidian-compile
```

Expected: compile skill includes update-first, insight promotion, and dashboard rules.

- [ ] **Step 4: Commit**

```bash
git add obsidian-compile
git commit -m "feat: add Obsidian compile skill"
```

### Task 6: `obsidian-retrieve` Skill

**Files:**
- Create: `/Users/picpal/Desktop/workspace/skills/obsidian-retrieve/SKILL.md`
- Create: `/Users/picpal/Desktop/workspace/skills/obsidian-retrieve/references/retrieve-workflow.md`

- [ ] **Step 1: Create `obsidian-retrieve/SKILL.md`**

```markdown
---
name: obsidian-retrieve
description: Retrieve evidence-linked answers from an Obsidian second-brain vault and save new insights, questions, decisions, or outputs when retrieval creates value.
---

# Obsidian Retrieve

Use this skill when the user asks a question that should be answered from the Obsidian second-brain vault.

## Core Rule

Start from Maps, then follow Object links, then open Source notes for evidence. Distinguish evidence from inference.

## Workflow

1. Identify the question and relevant topic area.
2. Read relevant `40_Maps` notes first.
3. Follow links into `30_Objects`.
4. Open supporting `20_Sources`.
5. Answer with evidence links and confidence.
6. If retrieval creates new value, save a candidate:
   - Insight
   - Question
   - Decision
   - Project action
   - Output note

## Answer Format

Use:

```markdown
## Answer

{{answer}}

## Evidence

- [[source-note]]: {{why_it_matters}}

## Inference

{{what_is_reasoned_beyond_sources}}

## Confidence

low | medium | high

## New Memory Candidates

- Insight:
- Question:
- Decision:
- Project action:
```

## Safety

- Do not hide weak evidence.
- Do not answer from memory alone when vault notes are available.
- Mark missing evidence as `needs_evidence`.

## References

- `../shared/obsidian-second-brain/references/workflows.md`
- `../shared/obsidian-second-brain/references/reliability.md`
- `references/retrieve-workflow.md`
```

- [ ] **Step 2: Create `retrieve-workflow.md`**

```markdown
# Retrieve Workflow

## Search Order

1. `40_Maps`
2. `30_Objects`
3. `20_Sources`
4. `50_Execution`
5. `60_Reviews`

## Evidence Rules

- Link Source notes whenever possible.
- Separate evidence from inference.
- Assign confidence.
- Create follow-up Question notes when evidence is missing.

## Writeback Rules

When a retrieval session produces a useful new connection, save it as an Insight candidate.

When it produces a choice, save it as a Decision candidate.

When it produces a concrete next step, link it to a Project note or create a Project action candidate.
```

- [ ] **Step 3: Verify retrieve skill**

Run:

```bash
test -f obsidian-retrieve/SKILL.md
test -f obsidian-retrieve/references/retrieve-workflow.md
rg -n "Start from Maps|Evidence|Inference|New Memory Candidates|needs_evidence" obsidian-retrieve
```

Expected: retrieve skill includes map-first retrieval, evidence, inference, and writeback rules.

- [ ] **Step 4: Commit**

```bash
git add obsidian-retrieve
git commit -m "feat: add Obsidian retrieve skill"
```

### Task 7: `obsidian-lint` Skill

**Files:**
- Create: `/Users/picpal/Desktop/workspace/skills/obsidian-lint/SKILL.md`
- Create: `/Users/picpal/Desktop/workspace/skills/obsidian-lint/references/lint-workflow.md`

- [ ] **Step 1: Create `obsidian-lint/SKILL.md`**

```markdown
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
6. Find unresolved questions.
7. Create a lint report in `60_Reviews/lint-reports`.
8. Update Home dashboard review items.

## Report Sections

- Orphan notes
- Merge candidates
- Stale claims
- Decisions needing review
- Missing evidence
- Unresolved questions
- Suggested next actions

## Safety

- Do not delete notes.
- Do not rewrite source content.
- Do not resolve contradictions automatically.
- Suggest changes clearly so the user can approve them.

## References

- `../shared/obsidian-second-brain/references/workflows.md`
- `../shared/obsidian-second-brain/references/reliability.md`
- `references/lint-workflow.md`
```

- [ ] **Step 2: Create `lint-workflow.md`**

```markdown
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

## Unresolved Questions

- [[question]]: missing next exploration

## Suggested Next Actions

- {{action}}
```
```

- [ ] **Step 3: Verify lint skill**

Run:

```bash
test -f obsidian-lint/SKILL.md
test -f obsidian-lint/references/lint-workflow.md
rg -n "orphan|Merge Candidates|Stale Claims|Missing Evidence|Do not delete" obsidian-lint
```

Expected: lint skill includes health checks and non-destructive safety rules.

- [ ] **Step 4: Commit**

```bash
git add obsidian-lint
git commit -m "feat: add Obsidian lint skill"
```

### Task 8: Verification Script and Final Documentation

**Files:**
- Create: `/Users/picpal/Desktop/workspace/skills/tools/verify-second-brain-skills.sh`
- Modify: `/Users/picpal/Desktop/workspace/skills/README.md`

- [ ] **Step 1: Create verification script**

Create `tools/verify-second-brain-skills.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

required_files=(
  "README.md"
  "shared/obsidian-second-brain/README.md"
  "shared/obsidian-second-brain/references/vault-structure.md"
  "shared/obsidian-second-brain/references/note-types.md"
  "shared/obsidian-second-brain/references/workflows.md"
  "shared/obsidian-second-brain/references/reliability.md"
  "shared/obsidian-second-brain/templates/source.md"
  "shared/obsidian-second-brain/templates/insight.md"
  "shared/obsidian-second-brain/templates/home-dashboard.md"
  "vault-template/00_System/dashboards/Home.md"
  "vault-template/00_System/templates/source.md"
  "vault-template/00_System/templates/insight.md"
  "obsidian-capture/SKILL.md"
  "obsidian-compile/SKILL.md"
  "obsidian-retrieve/SKILL.md"
  "obsidian-lint/SKILL.md"
)

for path in "${required_files[@]}"; do
  if [[ ! -f "$path" ]]; then
    echo "Missing required file: $path" >&2
    exit 1
  fi
done

required_dirs=(
  "vault-template/10_Capture/inbox"
  "vault-template/20_Sources/web"
  "vault-template/30_Objects/insights"
  "vault-template/40_Maps/topic-maps"
  "vault-template/50_Execution/projects"
  "vault-template/60_Reviews/lint-reports"
)

for path in "${required_dirs[@]}"; do
  if [[ ! -d "$path" ]]; then
    echo "Missing required directory: $path" >&2
    exit 1
  fi
done

grep -R "name: obsidian-capture" obsidian-capture/SKILL.md >/dev/null
grep -R "name: obsidian-compile" obsidian-compile/SKILL.md >/dev/null
grep -R "name: obsidian-retrieve" obsidian-retrieve/SKILL.md >/dev/null
grep -R "name: obsidian-lint" obsidian-lint/SKILL.md >/dev/null
grep -R "Merge Before Create" shared/obsidian-second-brain/references/reliability.md >/dev/null
grep -R "New Connection" shared/obsidian-second-brain/templates/insight.md >/dev/null
grep -R "Review Items" vault-template/00_System/dashboards/Home.md >/dev/null

if grep -R -E "T[B]D|TO[D]O|FIX[M]E" README.md shared vault-template obsidian-capture obsidian-compile obsidian-retrieve obsidian-lint >/dev/null; then
  echo "Found placeholder text." >&2
  exit 1
fi

echo "Second brain skill pack verification passed."
```

- [ ] **Step 2: Make script executable**

Run:

```bash
chmod +x tools/verify-second-brain-skills.sh
```

- [ ] **Step 3: Update root README with verification instructions**

Append this section to `README.md`:

```markdown
## Verification

Run:

```bash
./tools/verify-second-brain-skills.sh
```

Expected output:

```text
Second brain skill pack verification passed.
```
```

- [ ] **Step 4: Run verification**

Run:

```bash
./tools/verify-second-brain-skills.sh
```

Expected:

```text
Second brain skill pack verification passed.
```

- [ ] **Step 5: Review git status**

Run:

```bash
git status --short
```

Expected: only intended files are modified or added. `.DS_Store` and `.superpowers/` should not appear.

- [ ] **Step 6: Commit**

```bash
git add README.md tools/verify-second-brain-skills.sh
git commit -m "test: add second brain skill verification"
```

## Self-Review Checklist

- [x] The plan creates the vault structure from the approved design.
- [x] The plan creates all eight core note templates plus daily, weekly, and home dashboard templates.
- [x] The plan creates four skills: capture, compile, retrieve, lint.
- [x] Each skill has a clear responsibility and safety rules.
- [x] The plan includes source preservation, confidence, ambiguity, conflict, and merge-before-create rules.
- [x] The plan includes verification commands and a final verification script.
- [x] The plan avoids fully autonomous background agents in the first version.
- [x] The plan avoids placeholder text in produced artifacts.
