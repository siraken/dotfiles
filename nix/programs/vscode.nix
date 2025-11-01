{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles = {
      Default = {
        languageSnippets = {
          # C snippets
          c = {
            "Hello World" = {
              prefix = [ "helloworld" ];
              body = [
                "#include <stdio.h>"
                ""
                "int main(void) {"
                "    "
                "  char text[] = \"Hello, World\";"
                "  printf(\"%s\\n\", text);"
                ""
                "  return 0;"
                "}"
              ];
              description = "";
            };
          };

          # COBOL snippets
          cobol = {
            Initialize = {
              prefix = [ "init" ];
              body = [
                "PROGRAM-ID. HELLO."
                "PROCEDURE DIVISION."
                "MAIN SECTION."
                "\tDISPLAY \"HELLO WORLD\"."
                "STOP RUN."
              ];
              description = "";
            };
          };

          # C# snippets
          csharp = {
            "Hello World" = {
              prefix = [ "helloworld" ];
              body = [
                "using System;"
                "using System.Collections.Generic;"
                "using System.Linq;"
                "using System.Text;"
                "using System.Threading.Tasks;"
                ""
                "namespace $1"
                "{"
                "\tclass Program"
                "\t{"
                "\t\tstatic void Main(string[] args)"
                "\t\t{"
                "\t\t    Console.WriteLine(\"Hello World!\");"
                "\t\t}"
                "\t}"
                "}"
              ];
              description = "";
            };
          };

          # Docker Compose snippets
          dockercompose = {
            Compose = {
              prefix = [ "dc" ];
              body = [
                "version: '3'"
                "services:"
                "\t\${1:serviceName}:"
                "\t\tbuild:"
                "\t\t\tcontext: ."
                "\t\t\tdockerfile: Dockerfile"
                "\t\tvolumes:"
                "\t\t\t- .:/app"
                "\t\tports:"
                "\t\t\t- '\\\${PORT}:\\\${PORT}'"
                ""
                "volumes:"
                "\tsome-volume:"
              ];
              description = "";
            };
          };

          # Git commit snippets
          gitcommit = {
            feat = {
              prefix = [ "feat" ];
              body = [ "feat(\${1:scope}): \${2:message}" ];
              description = "";
            };
            fix = {
              prefix = [ "fix" ];
              body = [ "fix(\${1:scope}): \${2:message}" ];
              description = "";
            };
            chore = {
              prefix = [ "chore" ];
              body = [ "chore(\${1:scope}): \${2:message}" ];
              description = "";
            };
          };

          # Go snippets
          go = {
            "Create main function" = {
              prefix = [ "main" ];
              body = [
                "package main$1\n"
                "import ("
                "\t\"fmt\""
                ")\n"
                "func main() {"
                "\tfmt.Println(\"Hello World\")"
                "}"
              ];
              description = "";
            };
          };

          # JavaScript snippets
          javascript = {
            querySelector = {
              prefix = [ "qs" ];
              body = [ "document.querySelector('\${1:value}')" ];
              description = "";
            };
            querySelectorAll = {
              prefix = [ "qsa" ];
              body = [ "document.querySelectorAll('\${1:value}')" ];
              description = "";
            };
            getElementById = {
              prefix = [ "gebi" ];
              body = [ "document.getElementById('\${1:value}')" ];
              description = "";
            };
            getElementsByClassName = {
              prefix = [ "gebc" ];
              body = [ "document.getElementsByClassName('\${1:value}')" ];
              description = "";
            };
            "jQuery onClick" = {
              prefix = [ "jqoc" ];
              body = [
                "\\$('\${1:value}').on('click', function () {"
                "\t$2"
                "});"
              ];
              description = "";
            };
          };

          # JSON snippets
          json = {
            "Create a new snippet" = {
              prefix = [ "sn_new_snippet" ];
              body = [
                "\"\${1:snippetName}\": {"
                "\t\"prefix\": \"\","
                "\t\"body\": [\"\"],"
                "\t\"description\": \"\""
                "},"
              ];
              description = "Create a new snippet";
            };
            "Initialize package.json" = {
              prefix = [ "sn_package" ];
              body = [
                "{"
                "\t\"description\": \"\""
                "}"
              ];
              description = "Initialize package.json";
            };
          };

          # Markdown snippets
          markdown = {
            Initialize = {
              prefix = [ "mdinit" ];
              body = [
                "# \${1:Title}\n"
                "## Subtitle"
              ];
              description = "";
            };
            "Create a Checkbox" = {
              prefix = [ "cb" ];
              body = [ "- [ ] \${1:text}" ];
              description = "";
            };
            "Add a link" = {
              prefix = [ "ln" ];
              body = [ "[\${1:title}](\${2:url})" ];
              description = "";
            };
            "Insert an image" = {
              prefix = [ "img" ];
              body = [ "![\${1:title}](\${2:url})" ];
              description = "";
            };
            "Create a table" = {
              prefix = [ "tbl" ];
              body = [
                "| \${1:title} | \${2:content} |"
                "| :-- | :-- |"
                "| data | data |"
              ];
              description = "";
            };
            "Insert a code" = {
              prefix = [ "code" ];
              body = [ "```\${1:languageName}\n```" ];
              description = "";
            };
          };

          # PHP snippets
          php = {
            "Show PHP info" = {
              prefix = [ "sn_phpinfo" ];
              body = [ "<?php phpinfo(); ?>" ];
              description = "";
            };
            "Shorthand echo" = {
              prefix = [ "sn_echo" ];
              body = [ "<?= \${1:value} ?>" ];
              description = "";
            };
            "Create a PHP class" = {
              prefix = [ "sn_class" ];
              body = [
                "class \${1:ClassName} {"
                "\t$0"
                "}"
              ];
              description = "";
            };
            "Create a PHP function" = {
              prefix = [ "sn_function" ];
              body = [
                "function \${1:functionName}($2) {"
                "\t$0"
                "}"
              ];
              description = "";
            };
          };

          # Shell script snippets
          shellscript = {
            Initialize = {
              prefix = [ "init" ];
              body = [
                "#!/bin/bash\n"
                "CMD=$1"
                "ARGS=\${@:2}"
              ];
              description = "";
            };
          };

          # SQL snippets
          sql = {
            SELECT = {
              prefix = [ "select" ];
              body = [ "SELECT * FROM \${1:table}" ];
              description = "";
            };
            "SELECT WHERE" = {
              prefix = [ "selectwhere" ];
              body = [ "SELECT * FROM \${1:table} WHERE \${2:condition}" ];
              description = "";
            };
            INSERT = {
              prefix = [ "insert" ];
              body = [ "INSERT INTO \${1:table} (\${2:column}) VALUES (\${3:value})" ];
              description = "";
            };
            UPDATE = {
              prefix = [ "update" ];
              body = [ "UPDATE \${1:table} SET \${2:column} = \${3:value}" ];
              description = "";
            };
            DELETE = {
              prefix = [ "delete" ];
              body = [ "DELETE FROM \${1:table}" ];
              description = "";
            };
            "CREATE TABLE" = {
              prefix = [ "createtable" ];
              body = [ "CREATE TABLE \${1:table} (\${2:column} \${3:type})" ];
              description = "";
            };
            "CREATE DATABASE" = {
              prefix = [ "createdatabase" ];
              body = [ "CREATE DATABASE \${1:database}" ];
              description = "";
            };
          };

          # TypeScript snippets
          typescript = {
            "Create an arrow function" = {
              prefix = [ "af" ];
              body = [
                "const \${1:functionName} = () => {"
                "\t$2"
                "}"
              ];
              description = "";
            };
          };

          # TypeScript React snippets
          typescriptreact = {
            "Create a component" = {
              prefix = [ "component" ];
              body = [
                "const \${1:ComponentName} = () => {"
                "\treturn ("
                "\t\t<>"
                "\t\t\t<h1>Hello World</h1>"
                "\t\t</>"
                "\t)"
                "}"
              ];
              description = "";
            };
          };
        };

        # Global snippets
        globalSnippets = {
          "My English Name" = {
            prefix = [ "sn_name_en" ];
            body = [ "Kento Shirasawa" ];
            description = "";
          };
          "My Japanese Name" = {
            prefix = [ "sn_name_ja" ];
            body = [ "白澤 賢斗" ];
            description = "";
          };
          "My Website URL" = {
            prefix = [ "sn_website" ];
            body = [ "https://www.siraken.net" ];
            description = "";
          };
          "My Company Website URL" = {
            prefix = [ "sn_company_website" ];
            body = [ "https://www.novalumo.com" ];
            description = "";
          };
          "Lorem ipsum" = {
            prefix = [ "lorem" ];
            body = [
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
              "Amet cursus sit amet dictum sit amet justo."
              "Nunc non blandit massa enim nec dui."
              "Turpis egestas pretium aenean pharetra magna ac placerat vestibulum."
            ];
            description = "";
          };
          "Rabbit" = {
            prefix = [ "rabbit" ];
            body = [ "₍ ᐢ. ̫ .ᐢ ₎" ];
            description = "";
          };
        };
      };
    };
  };
}
