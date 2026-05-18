---
name: obsidian-init
description: Use when preparing an Obsidian second-brain vault before capture, compile, retrieve, lint, project, research, or decision workflows can run reliably.
---

# Obsidian Init

Use this skill when the user wants to create, connect, or verify an Obsidian second-brain vault for this skill pack.

## Core Rule

Initialization is non-destructive. Create missing structure and report what already exists; do not overwrite existing notes.

## When to Use

- The user is setting up the vault for the first time.
- The user wants to check whether capture, compile, retrieve, and lint can run safely.
- The vault path is new, uncertain, moved, or shared across tools.
- A workflow fails because expected folders, templates, dashboards, or schemas are missing.

## Workflow

1. Identify the vault path from the user, project config, or current context.
2. If the vault exists, run:
   ```bash
   <pack-root>/tools/verify-vault.sh /path/to/obsidian-vault
   ```
3. If verification fails or the vault is new, run:
   ```bash
   <pack-root>/tools/init-second-brain-vault.sh /path/to/obsidian-vault
   ```
4. Run verification again.
5. Report the vault path, dashboard path, template path, and any remaining missing items.
6. Tell the user the vault is ready for `obsidian-capture`, `obsidian-compile`, `obsidian-retrieve`, and `obsidian-lint` only after verification passes.

## Safety

- Do not overwrite existing files in the vault.
- Do not rename user notes during init.
- Do not delete old folders or old notes.
- Keep ambiguous existing material in place; later use lint or compile to reorganize it.
- If the user wants a destructive reset, stop and ask for explicit confirmation outside this skill.

## Expected Output

Successful init should leave these anchors in place:

- `00_System/dashboards/Home.md`
- `00_System/templates/`
- `00_System/schemas/note-types.md`
- `10_Capture/inbox/`
- `20_Sources/`
- `30_Objects/`
- `40_Maps/`
- `50_Execution/`
- `60_Reviews/`

## References

- `references/init-workflow.md`
- `../../shared/obsidian-second-brain/references/vault-structure.md`
- `../../shared/obsidian-second-brain/references/note-types.md`
- `../../shared/obsidian-second-brain/references/reliability.md`
