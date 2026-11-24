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
    (
      dir="$HOME/.claude"
      target="$dir/settings.json"
      state="${stateFile}"
      state_dir="$(dirname "$state")"

      if [[ -v DRY_RUN ]]; then
        noteEcho "claude-settings: would merge ${base} into $target (state: $state)"
        exit 0
      fi

      tmp_files=()
      trap '(( ''${#tmp_files[@]} == 0 )) || rm -f -- "''${tmp_files[@]}"' EXIT

      run mkdir -p "$dir" "$state_dir"

      if [ -L "$target" ]; then
        # Atomically replace the old link with a regular copy of what it pointed to.
        tmp="$(mktemp "$dir/.settings.json.XXXXXX")"
        tmp_files+=("$tmp")
        cat "$target" > "$tmp" 2>/dev/null || printf '{}\n' > "$tmp"
        chmod 0644 "$tmp"
        run mv -f "$tmp" "$target"
      fi

      if [ -e "$target" ] && ! ${jq} empty "$target" 2>/dev/null; then
        warnEcho "$target is not valid JSON; leaving it untouched"
      else
        runtime=/dev/null
        [ -e "$target" ] && runtime="$target"

        prev=/dev/null
        if [ -e "$state" ]; then
          if [ -s "$state" ] && ${jq} empty "$state" 2>/dev/null; then
            prev="$state"
          else
            warnEcho "$state is not valid JSON; ignoring previous base state"
          fi
        fi

        merged="$(mktemp "$dir/.settings.json.XXXXXX")"
        tmp_files+=("$merged")
        ${jq} -n -f ${mergeScript} \
          --slurpfile r "$runtime" \
          --slurpfile p "$prev" \
          --slurpfile b ${base} > "$merged"
        chmod 0644 "$merged"

        if [ -f "$target" ] && [ -w "$target" ] && cmp -s "$merged" "$target"; then
          rm -f "$merged"
        else
          run mv -f "$merged" "$target"
        fi

        if [ ! -f "$state" ] || [ -L "$state" ] || [ ! -w "$state" ] || ! cmp -s ${base} "$state"; then
          tmp_state="$(mktemp "$state_dir/.claude-settings-base.json.XXXXXX")"
          tmp_files+=("$tmp_state")
          cat ${base} > "$tmp_state"
          chmod 0644 "$tmp_state"
          run mv -f "$tmp_state" "$state"
        fi
      fi
    )
  '';
}
