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

## Verification

Run:

```bash
./tools/verify-second-brain-skills.sh
```

Expected output:

```text
Second brain skill pack verification passed.
```
