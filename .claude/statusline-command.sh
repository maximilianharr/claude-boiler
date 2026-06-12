#!/usr/bin/env bash
# Claude Code statusLine command — mirrors the bash PS1 from ~/.bashrc

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')

git_branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null)

if [ -n "$git_branch" ]; then
    branch_part=$(printf ' (%s)' "$git_branch")
else
    branch_part=""
fi

printf '\e[1;32m%s@%s\e[0m:\e[1;34m%s\e[0;33m%s\e[0m' \
    "$(whoami)" "$(hostname -s)" "$cwd" "$branch_part"
