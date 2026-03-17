#!/bin/bash
input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
dir=$(basename "$cwd")

# Model info
model=$(echo "$input" | jq -r '.model.id // "unknown"')

# Context usage (already a percentage)
context_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0')

# Color context based on usage: green < 50%, yellow 50-80%, red > 80%
if [ "$context_pct" -lt 50 ]; then
    ctx_color="\033[32m"  # green
elif [ "$context_pct" -lt 80 ]; then
    ctx_color="\033[33m"  # yellow
else
    ctx_color="\033[31m"  # red
fi

# Git info
git_info=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || echo "detached")

    # Detect if inside a worktree and extract its name
    git_dir=$(git -C "$cwd" rev-parse --git-dir 2>/dev/null)
    worktree_name=""
    if [[ "$git_dir" == *"/worktrees/"* ]]; then
        worktree_name="${git_dir##*/worktrees/}"
        worktree_name="${worktree_name%%/*}"
    fi

    if ! git -C "$cwd" diff --quiet --no-optional-locks 2>/dev/null || \
       ! git -C "$cwd" diff --cached --quiet --no-optional-locks 2>/dev/null; then
        git_info=$(printf ' \033[1;34mgit:(\033[31m%s\033[34m) \033[33m✗\033[0m' "$branch")
    else
        git_info=$(printf ' \033[1;34mgit:(\033[31m%s\033[34m)\033[0m' "$branch")
    fi

    # Append worktree name if present
    if [ -n "$worktree_name" ]; then
        git_info="$git_info$(printf ' \033[90m[wt:%s]\033[0m' "$worktree_name")"
    fi
fi

# Output: dir git_info | model | context%
printf '\033[36m%s\033[0m%s \033[90m│\033[0m \033[35m%s\033[0m \033[90m│\033[0m %b%d%%\033[0m' \
    "$dir" "$git_info" "$model" "$ctx_color" "$context_pct"
