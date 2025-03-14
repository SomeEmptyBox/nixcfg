{
  programs.firefox.policies = {
    DisableTelemetry = true;
    DisableFirefoxStudies = true;
    EnableTrackingProtection = {
      Value = true;
      Locked = true;
      Cryptomining = true;
      Fingerprinting = true;
    };
    DisablePocket = true;
    DisableFirefoxAccounts = true;
    DisableAccounts = true;
    DisableFirefoxScreenshots = true;
    OverrideFirstRunPage = "";
    OverridePostUpdatePage = "";
    DontCheckDefaultBrowser = true;
    DisplayMenuBar = "never"; # alternatives: "always", "never" or "default-on"
    SearchBar = "unified";
    PasswordManagerEnabled = false;
  };
}
