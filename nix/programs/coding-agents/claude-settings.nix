# ~/.claude/settings.json as a regular file: the repo's declarative base
# (home/.claude/settings.json) merged into whatever Claude Code and other tools
# have written at runtime.
#
# It used to be an out-of-store symlink into the repo, so every runtime write
# (auto mode environment notes, hooks installed by other apps, /config changes,
# backups) landed in the public repo's worktree. Now the runtime state stays in
# ~/.claude, and a repo edit takes effect on the next switch.
#
# The merge is three-way (see merge-settings.jq): the base applied by the
# previous switch is kept under $XDG_STATE_HOME, so an entry removed from the
# repo is removed locally while entries added at runtime survive.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  jq = lib.getExe pkgs.jq;
  base = ../../../home/.claude/settings.json;
  mergeScript = ./merge-settings.jq;
  stateFile = "${config.xdg.stateHome}/dotfiles/claude-settings-base.json";
in
{
  # Before linkGeneration: on the first switch the file is still the old
  # symlink, and its content (the runtime state so far) has to be captured
  # before home-manager cleans up links of the previous generation.
  home.activation.claudeSettings = lib.hm.dag.entryBetween [ "linkGeneration" ] [ "writeBoundary" ] ''
    target="$HOME/.claude/settings.json"
    state="${stateFile}"
    run mkdir -p "$HOME/.claude" "$(dirname "$state")"

    if [ -L "$target" ]; then
      # Replace the old link with a regular copy of what it pointed to.
      tmp="$(mktemp)"
      cat "$target" > "$tmp" 2>/dev/null || echo '{}' > "$tmp"
      run rm "$target"
      run mv "$tmp" "$target"
    fi
    [ -e "$target" ] || run sh -c "echo '{}' > \"$target\""

    if ! ${jq} empty "$target" 2>/dev/null; then
      warnEcho "$target is not valid JSON; leaving it untouched"
    else
      prev=/dev/null
      [ -e "$state" ] && prev="$state"
      merged="$(mktemp)"
      ${jq} -n -f ${mergeScript} \
        --slurpfile r "$target" \
        --slurpfile p "$prev" \
        --slurpfile b ${base} > "$merged"
      if cmp -s "$merged" "$target"; then
        rm "$merged"
      else
        run mv "$merged" "$target"
      fi
      run cp ${base} "$state"
      run chmod u+w "$state"
    fi
  '';
}
