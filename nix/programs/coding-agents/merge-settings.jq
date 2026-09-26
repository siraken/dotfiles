# Three-way merge of Claude Code's user settings.
#
#   $r: the live ~/.claude/settings.json (what Claude Code and other tools
#       have written at runtime)
#   $p: the repo base applied by the previous switch (null on the first run)
#   $b: the repo base being applied now (home/.claude/settings.json)
#
# - A key the repo declares takes the repo's value; objects merge recursively.
# - Arrays keep the entries added at runtime: (runtime - previous base) are
#   appended to the new base, so an entry deleted from the repo disappears
#   while hooks or permissions added by tools survive.
# - A key the previous base declared but the new one does not is removed.
# - Every other key (runtime-only state) is kept as is.
def merge3($r; $p; $b):
  if ($b | type) == "object" then
    ($r | if type == "object" then . else {} end) as $r
    | ($p | if type == "object" then . else {} end) as $p
    | reduce (($r | keys) + ($b | keys) | unique)[] as $k ({};
        if ($b | has($k)) then . + {($k): merge3($r[$k]; $p[$k]; $b[$k])}
        elif ($p | has($k)) then .
        else . + {($k): $r[$k]}
        end)
  elif ($b | type) == "array" then
    ($r | if type == "array" then . else [] end) as $r
    | ($p | if type == "array" then . else [] end) as $p
    | $b + (($r - $p) - $b)
  else
    $b
  end;

merge3($r[0]; $p[0]; $b[0])
