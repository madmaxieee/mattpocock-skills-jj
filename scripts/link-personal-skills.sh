#!/usr/bin/env bash
set -euo pipefail

# Link the promoted set without replacing existing installations.
REPO="$(cd "$(dirname "$0")/.." && pwd)"
if [ "$#" -gt 0 ]; then
  DESTS=("$@")
else
  DESTS=("$HOME/.agents/skills" "$HOME/.claude/skills")
fi

# Preflight every destination before creating any links.
for dest in "${DESTS[@]}"; do
  if [ -L "$dest" ]; then
    echo "Refusing symlinked destination: $dest" >&2
    exit 1
  fi
  for source in "$REPO"/skills/engineering/* "$REPO"/skills/productivity/*; do
    [ -f "$source/SKILL.md" ] || continue
    target="$dest/$(basename "$source")"
    if [ -e "$target" ] || [ -L "$target" ]; then
      if [ ! -L "$target" ] || [ "$(readlink "$target")" != "$source" ]; then
        echo "Existing installation conflicts: $target. Move it aside before retrying." >&2
        exit 1
      fi
    fi
  done
done

for dest in "${DESTS[@]}"; do
  mkdir -p "$dest"
  for source in "$REPO"/skills/engineering/* "$REPO"/skills/productivity/*; do
    [ -f "$source/SKILL.md" ] || continue
    target="$dest/$(basename "$source")"
    [ -L "$target" ] || ln -s "$source" "$target"
    echo "linked $target -> $source"
  done
done
