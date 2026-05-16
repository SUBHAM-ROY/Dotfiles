{ ... }:

{
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--no-ignore"
      "--hidden"
      "--follow"
      "--glob=!.git"
      "--glob=!.venv"
      "--glob=!node_modules"
      "--glob=!.mypy_cache"
    ];
  };
}
