{ ... }:

{
  programs.lazygit = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "gg";
    settings = {
      gui = {
        skipAmendWarning = true;
        skipStashWarning = true;
        nerdFontsVersion = 3;
      };
      git = {
        pagers = [
          { pager = "delta --dark --paging=never"; }
        ];
        branchPrefix = "subham/";
      };
      notARepository = "skip";
      customCommands = [
        {
          key = "<c-p>";
          context = "localBranches";
          command = "git push origin {{.SelectedLocalBranch.Name}}";
          description = "Push selected branch to origin";
        }
        {
          key = "<c-l>";
          context = "localBranches";
          command = "git pull --rebase origin {{.SelectedLocalBranch.Name}}";
          description = "Pull from origin with rebase";
          loadingText = "Pulling...";
        }
      ];
    };
  };
}
