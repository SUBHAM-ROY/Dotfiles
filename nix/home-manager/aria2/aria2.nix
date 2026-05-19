{ ... }:

{
  programs.aria2 = {
    enable = true;
    settings = {
      max-concurrent-downloads = 1;
      max-connection-per-server = 5;
      continue = true;
      summary-interval = 300;
    };
  };
}
