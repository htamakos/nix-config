{ pkgs
, userConfig
, ...
}: {
  # Nix Settings
  nix.optimise.automatic = true;
  nix.settings = {
    experimental-features = "nix-command flakes";
  };
  services.nix-daemon.enable = true;

  # User Config
  users.users.${userConfig.name} = {
    name = "${userConfig.name}";
    home = "/Users/${userConfig.name}";
  };

  # System Settings
  system = {
    defaults = {
      NSGlobalDomain = {
        # Dark モードの設定
        AppleInterfaceStyle = "Dark";

        # 全ての拡張子のファイルを表示
        AppleShowAllExtensions = true;

        # 全てのファイル(隠しファイルを含む)を表示
        AppleShowAllFiles = true;

        # 常にスクロールバーを表示
        AppleShowScrollBars = "Always";

        # 自動大文字の無効化
        NSAutomaticCapitalizationEnabled = false;

        # キーリーピートまでの認識時間(1 = 15ms)
        InitialKeyRepeat = 10;

        # キーリーピートの速度(1 = 15ms)
        KeyRepeat = 2;

        # smart dash の無効化
        NSAutomaticDashSubstitutionEnabled = false;

        # smart quote の無効化
        NSAutomaticQuoteSubstitutionEnabled = false;

        # 自動スペル補完の無効化
        NSAutomaticSpellingCorrectionEnabled = false;

        NSAutomaticWindowAnimationsEnabled = false;

        # iCloud へのドキュメント自動保存
        NSDocumentSaveNewDocumentsToCloud = false;

        # 保存ダイアログボックスをデフォルトで詳細表示に設定
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;

        # 印刷ダイアログボックスをデフォルトで詳細表示に設定
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;

        # 制御文字を表示する
        NSTextShowsControlCharacters = true;

        # トラックパッドのタップの挙動(1=click)
        "com.apple.mouse.tapBehavior" = 1;
      };

      LaunchServices = {
        # Web からダウンロードした file の実行時に対する警告を無効化する
        LSQuarantine = false;
      };

      trackpad = {
        # タップによるクリックを有効化する
        Clicking = true;

        # トラックパッドでの右クリックを有効化する
        TrackpadRightClick = true;

        # 3本指でのドラッグを有効化する
        TrackpadThreeFingerDrag = true;
      };

      finder = {
        # ステータスバーの表示
        ShowStatusBar = true;

        # パスバーの表示
        ShowPathbar = true;

        # 検索スコープをデフォルトで現在のディレクトリに設定する
        FXDefaultSearchScope = "SCcf";

        # POSIX 形式のファイルパスを表示する
        _FXShowPosixPathInTitle = true;

        # デフォルトの View スタイルをリストにする
        FXPreferredViewStyle = "Nlsv";

        # 名前で並べ替えを選択時にディレクトリを前に置くようにする
        _FXSortFoldersFirst = true;

        # 拡張子変更時の警告を無効化
        FXEnableExtensionChangeWarning = false;
      };

      dock = {
        # Dock を自動的に隠す
        autohide = true;

        # Dockで開いているアプリケーションのインジケータライトを表示する
        show-process-indicators = true;

        # アプリケーション起動時のアニメーション無効化
        launchanim = false;

        # Dock の位置を左に
        orientation = "left";

        # アプリを隠したらDock上のアイコンを半透明に設定
        showhidden = true;

        # Dock のアイコンサイズ
        tilesize = 32;

        # https://daiderd.com/nix-darwin/manual/index.html#opt-system.defaults.dock.wvous-bl-corner
        wvous-bl-corner = 1;
        # https://daiderd.com/nix-darwin/manual/index.html#opt-system.defaults.dock.wvous-br-corner
        wvous-br-corner = 1;
        # https://daiderd.com/nix-darwin/manual/index.html#opt-system.defaults.dock.wvous-tl-corner
        wvous-tl-corner = 1;
        # https://daiderd.com/nix-darwin/manual/index.html#opt-system.defaults.dock.wvous-tr-corner
        wvous-tr-corner = 1;

        #persistent-apps = [
        #    "/Applications/Google Chrome.app"
        #    "/Applications/Slack.app"
        #    "/Applications/Microsoft Excel.app"
        #    "/Applications/Microsoft PowerPoint.app"
        #    "/Applications/Microsoft Remote Desktop.app"
        #    "/Applications/Microsoft Outlook.app"
        #    "/Applications/iTerm.app"
        #    "/Applications/Kindle.app"
        #];
      };

      screencapture = {
        location = "/Users/${userConfig.name}/Downloads/screencapture";
        type = "png";
        disable-shadow = true;

        # 保存前にサムネイルを表示する
        show-thumbnail = true;

        target = "file";
      };
    };
  };

  power = {
    # フリーズした時に自動再起動する
    restartAfterFreeze = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
    };
    brews = [
      "exa"
      "llama.cpp"
    ];
    casks = [
      # Keybind
      "karabiner-elements"

      # Browser
      "firefox"
      "google-chrome"

      # Terminal
      "warp"
      "iterm2"

      # Video Meeting
      "zoom"

      # Otethers
      "alfred"
      "kitty"
      # "drawio"
      "google-japanese-ime"
    ];

    masApps = {
      #"Microsoft Remote Desktop" = 1295203466;
      #Zustand"XCode" = 497799835;
      #"Kindle" = 302584613;
    };
  };

  programs.zsh.enable = true;

  system.stateVersion = 5;
}
