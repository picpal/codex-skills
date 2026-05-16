#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
codex_home="${CODEX_HOME:-$HOME/.codex}"
skills_dir="$codex_home/skills"

install_paths=(
  "obsidian-init"
  "obsidian-capture"
  "obsidian-compile"
  "obsidian-retrieve"
  "obsidian-lint"
  "shared"
  "tools"
  "vault-template"
)

mkdir -p "$skills_dir"

linked=0
kept=0

for rel in "${install_paths[@]}"; do
  source_path="$repo_root/$rel"
  target_path="$skills_dir/$rel"

  if [[ ! -e "$source_path" ]]; then
    echo "Missing source path: $source_path" >&2
    exit 1
  fi

  if [[ -L "$target_path" ]]; then
    current_target="$(readlink "$target_path")"
    if [[ "$current_target" == "$source_path" ]]; then
      kept=$((kept + 1))
      continue
    fi

    echo "Existing symlink points elsewhere: $target_path -> $current_target" >&2
    exit 1
  fi

  if [[ -e "$target_path" ]]; then
    echo "Existing path would be overwritten, stopping: $target_path" >&2
    exit 1
  fi

  ln -s "$source_path" "$target_path"
  linked=$((linked + 1))
done

cat <<REPORT
Installed Obsidian second brain skills for Codex.
Codex skills directory: $skills_dir
New links created: $linked
Existing links kept: $kept
Restart Codex or open a new Codex session to load the skills.
REPORT
