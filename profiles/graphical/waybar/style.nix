{config, ...}: let
  inherit (config.vars.colorScheme) colors;
in ''
  * {
      border: none;
      border-radius: 0;
      font-family: Iosevka Nerd Font;
      font-size: 14px;
      min-height: 0;
  }

  window#waybar {
      background: transparent;
      color: white;
  }

  #workspaces {
  	background-color: #24283b;
  	margin: 5px;
  	margin-left: 10px;
  	border-radius: 5px;
  }
  #workspaces button {
      padding: 5px 10px;
      color: #c0caf5;
  }

  #workspaces button.active {
      color: #24283b;
      background-color: #7aa2f7;
      border-radius: 5px;
  }

  #workspaces button:hover {
  	background-color: #7dcfff;
  	color: #24283b;
  	border-radius: 5px;
  }

  #tray {
      color: #24283b;
      border-radius: 5px;
  }

  #tray, #custom-date, #clock, #battery, #pulseaudio, #network {
  	background-color: #24283b;
  	padding: 5px 10px;
  	margin: 5px 0px;
  }

  #custom-date {
  	color: #7dcfff;
  }

  #custom-power {
  	color: #24283b;
  	background-color: #db4b4b;
  	border-radius: 5px;
  	margin-right: 10px;
  	margin-top: 5px;
  	margin-bottom: 5px;
  	margin-left: 0px;
  	padding: 5px 10px;
  }

  #clock {
      color: #b48ead;
      border-radius: 0px 5px 5px 0px;
      margin-right: 10px;
  }

  #battery {
      color: #9ece6a;
  }

  #battery.charging {
      color: #9ece6a;
  }

  #battery.warning:not(.charging) {
      background-color: #f7768e;
      color: #24283b;
      border-radius: 5px 5px 5px 5px;
  }

  #network {
  	color: #f7768e;
  	border-radius: 5px 0px 0px 5px;
  }

  #pulseaudio {
  	color: #e0af68;
  }
''
