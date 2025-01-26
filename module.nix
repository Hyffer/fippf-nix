{ config, lib, pkgs, ... }:

let
  cfg = config.services.fippf;
in
{
  options.services.fippf = {
    enable = lib.mkEnableOption "FIPPF as a systemd service";

    package = lib.mkPackageOption pkgs "fippf" { };

    configDir = lib.mkOption {
      type = lib.types.path;
      default = "/etc/fippf";
      description = "FIPPF service configration directory.";
    };

    logLevel = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "FIPPI service log level (debug/info/warn/error).";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.fippf = {
      before = [ "multi-user.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = lib.concatStringsSep " " [
          (lib.getExe cfg.package)
          "--config_dir ${cfg.configDir}"
          (lib.optionalString (cfg.logLevel != null) "--log_level ${cfg.logLevel}")
        ];
      };
    };
  };

}
