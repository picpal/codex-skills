#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
cd "$repo_root"

required_files=(
  "README.md"
  "INSTALL.ko.md"
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
  "tools/init-second-brain-vault.sh"
  "tools/install-codex-skills.sh"
  "tools/verify-vault.sh"
  "obsidian-init/SKILL.md"
  "obsidian-init/references/init-workflow.md"
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
grep -R "name: obsidian-init" obsidian-init/SKILL.md >/dev/null
grep -R "name: obsidian-compile" obsidian-compile/SKILL.md >/dev/null
grep -R "name: obsidian-retrieve" obsidian-retrieve/SKILL.md >/dev/null
grep -R "name: obsidian-lint" obsidian-lint/SKILL.md >/dev/null
grep -R "Init Flow" shared/obsidian-second-brain/references/workflows.md >/dev/null
grep -R "설치 가이드" INSTALL.ko.md >/dev/null
grep -R "Obsidian second brain vault verification passed" tools/verify-vault.sh >/dev/null
grep -R "Merge Before Create" shared/obsidian-second-brain/references/reliability.md >/dev/null
grep -R "New Connection" shared/obsidian-second-brain/templates/insight.md >/dev/null
grep -R "Review Items" vault-template/00_System/dashboards/Home.md >/dev/null
grep -R "Retrospectives" shared/obsidian-second-brain/templates/project.md >/dev/null
grep -R "Retrospectives" vault-template/00_System/templates/project.md >/dev/null
grep -R "Output" obsidian-retrieve/SKILL.md >/dev/null
grep -R "Broken Links" obsidian-lint/references/lint-workflow.md >/dev/null

if [[ ! -x tools/init-second-brain-vault.sh ]]; then
  echo "Script is not executable: tools/init-second-brain-vault.sh" >&2
  exit 1
fi

if [[ ! -x tools/install-codex-skills.sh ]]; then
  echo "Script is not executable: tools/install-codex-skills.sh" >&2
  exit 1
fi

if [[ ! -x tools/verify-vault.sh ]]; then
  echo "Script is not executable: tools/verify-vault.sh" >&2
  exit 1
fi

if grep -R -E "T[B]D|TO[D]O|FIX[M]E" README.md shared vault-template obsidian-init obsidian-capture obsidian-compile obsidian-retrieve obsidian-lint >/dev/null; then
  echo "Found placeholder text." >&2
  exit 1
fi

echo "Second brain skill pack verification passed."
