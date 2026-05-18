#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
codex_home="${CODEX_HOME:-$HOME/.codex}"
skills_dir="$codex_home/skills"
pack_support_dir="$skills_dir/.packs"

mkdir -p "$skills_dir" "$pack_support_dir"

linked=0
kept=0

install_link() {
  local source_path="$1"
  local target_path="$2"
 
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
}

install_skill_dir() {
  local skill_dir="$1"
  local skill_name

  skill_name="$(basename "$skill_dir")"
  if [[ ! -f "$skill_dir/SKILL.md" ]]; then
    echo "Missing SKILL.md: $skill_dir" >&2
    exit 1
  fi

  install_link "$skill_dir" "$skills_dir/$skill_name"
}

shopt -s nullglob

for skill_dir in "$repo_root"/skills/*; do
  [[ -d "$skill_dir" ]] || continue
  install_skill_dir "$skill_dir"
done

for pack_dir in "$repo_root"/packs/*; do
  [[ -d "$pack_dir" ]] || continue

  pack_name="$(basename "$pack_dir")"
  install_link "$pack_dir" "$pack_support_dir/$pack_name"

  for skill_dir in "$pack_dir"/skills/*; do
    [[ -d "$skill_dir" ]] || continue
    install_skill_dir "$skill_dir"
  done
done

cat <<REPORT
Installed Codex skills from this repository.
Codex skills directory: $skills_dir
Pack support directory: $pack_support_dir
New links created: $linked
Existing links kept: $kept
Restart Codex or open a new Codex session to load the skills.
REPORT
