{ ... }:
{
  programs.keepassxc = {
    enable = true;
    settings = {
      General = {
        ConfigVersion = 2;
        MinimizeAfterUnlock = true;
      };
      Browser = {
        Enabled = true;
        UpdateBinaryPath = false;
      };
      GUI = {
        MinimizeOnClose = true;
        MinimizeToTray = true;
        ShowExpiredEntriesOnDatabaseUnlockOffsetDays = 0;
        ShowTrayIcon = true;
        TrayIconAppearance = "monochrome-dark";
      };
    };
  };
}
