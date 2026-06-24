{ pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.isLinux {
  programs.opencode = {
    enable = true;

    context = ''
      ## Research Before Answering
      - Before making claims or assumptions, do a parallel web search with multiple sources and verify with the actual code/files before answering.

      ## File Search
      - Prefer `fd` over `find` for file search

      ## Content Search
      - Prefer `rg` over `grep` for content search

      ## JSON Processing
      - For simple queries, use `jq`
      - For complex Python-based processing, use `python3 -m json.tool`

      ## Sudo Commands
      - When a command requires sudo, pipe the password through `kdialog`: `kdialog --password "Enter password" | sudo -S <cmd>`
    '';

    settings = {
      permission = {
        bash = {
          "*" = "ask";
          "ls *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "fd *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "find *" = lib.hm.dag.entryAfter [ "*" ] "allow";
        };
        edit = "ask";
      };
    };

    tui = {
      theme = "nord";
    };
  };
}
