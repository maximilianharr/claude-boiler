#!/usr/bin/env bash
# Claude Code statusLine command

input=$(cat)

# 1. Path
cwd=$(echo "$input" | jq -r '.cwd')

# 2. Git branch
git_branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
if [ -n "$git_branch" ]; then
    branch_part=$(printf '\e[0;33m(%s)\e[0m ' "$git_branch")
else
    branch_part=""
fi

# 3. Model name — extract short label from display_name
model_display=$(echo "$input" | jq -r '.model.display_name // empty')
# Shorten: "Claude 3.5 Haiku" -> "haiku", "Claude Sonnet 4.5" -> "sonnet4.5", etc.
model_short=$(echo "$model_display" \
    | tr '[:upper:]' '[:lower:]' \
    | sed 's/claude[[:space:]]*//' \
    | sed 's/[[:space:]]//g')

# 4. Context usage %
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used_pct" ]; then
    ctx_part=$(printf 'ctx:%.0f%%' "$used_pct")
else
    ctx_part="ctx:--"
fi

# 5. Tokens-in (total input tokens, formatted as e.g. 98k)
total_in=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
if [ -n "$total_in" ] && [ "$total_in" != "0" ]; then
    if [ "$total_in" -ge 1000 ]; then
        in_fmt=$(awk "BEGIN { printf \"%.0fk\", $total_in/1000 }")
    else
        in_fmt="${total_in}"
    fi
    in_part="in:${in_fmt}"
else
    in_part="in:--"
fi

# 6. Tokens-out (total output tokens, formatted as e.g. 5k)
total_out=$(echo "$input" | jq -r '.context_window.total_output_tokens // empty')
if [ -n "$total_out" ] && [ "$total_out" != "0" ]; then
    if [ "$total_out" -ge 1000 ]; then
        out_fmt=$(awk "BEGIN { printf \"%.0fk\", $total_out/1000 }")
    else
        out_fmt="${total_out}"
    fi
    out_part="out:${out_fmt}"
else
    out_part="out:--"
fi

printf '\e[1;34m%s\e[0m %s\e[0;36m%s\e[0m \e[0;35m%s %s %s\e[0m' \
    "$cwd" \
    "$branch_part" \
    "$model_short" \
    "$ctx_part" "$in_part" "$out_part"
