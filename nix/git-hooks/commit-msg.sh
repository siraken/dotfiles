#!/usr/bin/env bash
# commit-msg hook: enforce the "Git Commit Guidelines" in AGENTS.md.
#
# - The subject is `type(scope): description` (Conventional Commits).
# - It is at most 72 characters; over 50 prints a warning but passes, since
#   the guideline asks for under 50 and a third of the history is longer.
# - Messages git or nix write themselves (merge, revert, fixup!/squash!/amend!,
#   `nix flake update --commit-lock-file`) pass unchanged.
#
# Bypass a single commit with `git commit --no-verify`.
set -euo pipefail

types="feat|fix|docs|style|refactor|perf|test|chore|ci|build|revert"
hard_limit=72
soft_limit=50

# First line that is neither blank nor a comment. Git strips comments only
# after this hook has run.
subject="$(grep -v -m1 -E '^[[:space:]]*(#|$)' "$1" || true)"

if [ -z "$subject" ]; then
  # An empty message is rejected by git itself.
  exit 0
fi

case "$subject" in
"Merge "* | 'Revert "'* | "fixup! "* | "squash! "* | "amend! "* | "flake.lock: Update")
  exit 0
  ;;
esac

if ! grep -q -E "^(${types})(\([a-z0-9._/-]+\))?!?: [^ ]" <<<"$subject"; then
  cat >&2 <<EOF
commit-msg: the subject does not follow Conventional Commits:

  ${subject}

Expected \`type(scope): description\`, for example:

  feat(nixvim): add a keymap for the file info
  fix: skip rustaceanvim tests on Darwin

Types: ${types//|/, }
EOF
  exit 1
fi

length=${#subject}
if [ "$length" -gt "$hard_limit" ]; then
  echo "commit-msg: the subject is ${length} characters; keep it within ${hard_limit} (ideally ${soft_limit})." >&2
  exit 1
fi
if [ "$length" -gt "$soft_limit" ]; then
  echo "commit-msg: warning: the subject is ${length} characters; the guideline is under ${soft_limit}." >&2
fi
