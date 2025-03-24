{ config, lib, pkgs, ... }:

let
  cfg = config.services.fippf;

  # https://discourse.nixos.org/t/list-installed-packages-without-version-numbers/25453
  installedPackages = lib.unique (
    builtins.map (p: "${p.pname or p.name}") config.environment.systemPackages
  );
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
      description = "FIPPF service log level (debug/info/warn/error).";
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

      # add nmcli and networkctl to PATH if they are installed
      path = with pkgs;
        lib.optionals (builtins.elem "networkmanager" installedPackages) [ networkmanager ]
        ++ lib.optionals (builtins.elem "systemd" installedPackages) [ systemd ];
    };
  };

}
