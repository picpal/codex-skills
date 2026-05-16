#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
cd "$repo_root"

required_files=(
  "README.md"
  "INSTALL.ko.md"
  "tools/install-codex-skills.sh"
  "packs/obsidian-second-brain/README.md"
  "packs/obsidian-second-brain/tools/verify-second-brain-skills.sh"
)

for path in "${required_files[@]}"; do
  if [[ ! -f "$path" ]]; then
    echo "Missing required file: $path" >&2
    exit 1
  fi
done

if [[ ! -x tools/install-codex-skills.sh ]]; then
  echo "Script is not executable: tools/install-codex-skills.sh" >&2
  exit 1
fi

if [[ ! -x packs/obsidian-second-brain/tools/verify-second-brain-skills.sh ]]; then
  echo "Script is not executable: packs/obsidian-second-brain/tools/verify-second-brain-skills.sh" >&2
  exit 1
fi

skill_count="$(find skills packs -path '*/SKILL.md' -type f | wc -l | tr -d ' ')"
if [[ "$skill_count" -lt 1 ]]; then
  echo "No skills found." >&2
  exit 1
fi

packs/obsidian-second-brain/tools/verify-second-brain-skills.sh

if grep -R -E "T[B]D|TO[D]O|FIX[M]E" README.md INSTALL.ko.md skills packs tools >/dev/null; then
  echo "Found placeholder text." >&2
  exit 1
fi

echo "Codex skill repository verification passed."
