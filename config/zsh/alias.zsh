# Conditional aliases (require command existence check)

# Package managers (via Socket Firewall).
# sfw は Nix 管理外なので、入っていない環境では素のコマンドをそのまま使う。
if type sfw >/dev/null 2>&1; then
  for _pm in npm npx yarn pnpm pnpx bun bunx; do
    alias "$_pm"="sfw $_pm"
  done
  unset _pm
fi
