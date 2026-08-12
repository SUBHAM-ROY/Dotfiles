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

      ## Commands
      - When the user asks to copy a command, use `wl-copy`: `echo '<command>' | wl-copy`
      - When a command requires sudo, pipe the password through `kdialog`: `kdialog --password "Enter password" | sudo -S <cmd>`
      - When multiple sudo commands are needed, run them one by one with separate `kdialog` calls instead of chaining them
    '';

    settings = {
      permission = {
        bash = {
          "*" = "ask";
          "ls *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "fd *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "find *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "which *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "pwd" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "id" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "whoami" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "uname *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "date *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "echo *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "type *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "lsblk *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "lspci *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "lsusb *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "df *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "free *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "du *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "stat *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "git status" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "git diff *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "git log *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "git branch" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "git branch --list *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "git branch --show-current" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "git show *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "git stash list" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "git remote -v" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "git remote show *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "git describe *" = lib.hm.dag.entryAfter [ "*" ] "allow";
          "git rev-parse *" = lib.hm.dag.entryAfter [ "*" ] "allow";
        };
        edit = "ask";
      };
    };

    tui = {
      theme = "nord";
    };
  };
}
