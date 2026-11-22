# Rex (https://rex.superlogical.com) は nixpkgs にも Homebrew cask にもないので、
# アプリ本体は手で入れる (nixpkgs の `rex` は同名の別物)。ここでは設定ファイルを
# リポジトリから link するだけ。Rex は XDG_CONFIG_HOME を見るので macOS でも
# ~/.config/rex/init.lua になる。
{ mkRepoLink, ... }:
{
  home.file.".config/rex/init.lua".source = mkRepoLink "config/rex/init.lua";
}
