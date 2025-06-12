{ config, lib, pkgs, ...}:
with lib;

let
  auto-profile-tg = pkgs.callPackage ./default.nix {};

  cfg = config.services.auto-profile-tg;

in {
  options.services.auto-profile-tg.enable = mkEnableOption "auto-profile-tg";

  # Telegram API credentials from my.telegram.org
  options.services.auto-profile-tg.app-id = mkOption {
    type = types.int;
    default = 0;
    example = 12345678;
    description = "";
  };

  options.services.auto-profile-tg.api-hash = mkOption {
    type = types.str;
    default = "";
  };

  options.services.auto-profile-tg.phone-number = mkOption {
    type = types.str;
    example = "+998123456789";
  };

  options.services.auto-profile-tg.first-name = mkOption {
    type = types.str;
    example = "John";
  };

  options.services.auto-profile-tg.lat = mkOption {
    type = types.str;
    example = "41.2995";
  };

  options.services.auto-profile-tg.lon = mkOption {
    type = types.str;
    example = "69.2401";
  };

  options.services.auto-profile-tg.timezone = mkOption {
    type = types.str;
    example = "Asia/Tashkent";
  };

  options.services.auto-profile-tg.city = mkOption {
    type = types.str;
    example = "Tashkent";
  };

  options.services.auto-profile-tg.weather-api-key = mkOption {
    type = types.str;
  };

  config = mkIf cfg.enable {

    systemd.services.auto-profile-tg = {
      description = "run the bot on systemd";
      environment = {
        PYTHONUNBUFFERED = "1";
      };
      
      after = [ "network.target" ];
      wantedBy = [ "network.target" ];

      ExecStart = "${auto-profile-tg}/bin/main.py";
      Restart = "always";
      RestartSec = "5";
    };
  };
}