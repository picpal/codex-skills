# Obsidian Second Brain Skills

This repository contains an Obsidian second-brain skill pack for Codex and Claude Code.

The system is designed around one principle:

> Capture freely, preserve sources, compile knowledge, surface insights, and connect insights to execution.

## Contents

- `vault-template/`: starter Obsidian vault structure.
- `shared/obsidian-second-brain/`: shared references and note templates.
- `obsidian-init/`: skill for initial vault setup and connection checks.
- `obsidian-capture/`: skill for frictionless raw input capture.
- `obsidian-compile/`: skill for turning sources into linked memory.
- `obsidian-retrieve/`: skill for answering questions from the vault.
- `obsidian-lint/`: skill for memory health checks and review reports.

## Workflow

1. Initialize or verify the vault structure.
2. Capture raw material or freeform thoughts.
3. Preserve the source and metadata.
4. Compile into objects, maps, insights, projects, and decisions.
5. Retrieve from maps and sources with evidence links.
6. Lint the vault to find stale claims, weak evidence, duplicate notes, and missed links.

## Initialize a Vault

Run:

```bash
./tools/init-second-brain-vault.sh /path/to/obsidian-vault
./tools/verify-vault.sh /path/to/obsidian-vault
```

The initializer is non-destructive: it creates missing folders and copies missing templates, schemas, and dashboards, but keeps existing files unchanged.

Expected vault verification output:

```text
Obsidian second brain vault verification passed.
```

## Verification

Verify the skill pack itself:

```bash
./tools/verify-second-brain-skills.sh
```

Expected output:

```text
Second brain skill pack verification passed.
```
