{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "fippf";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "Hyffer";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-33FvdCg1+Yr6kJ85zOa42z/rZjIHsFmHCdzNfY0l/4I=";
  };

  vendorHash = "sha256-LYq69z8Ey+62BlZLW6JlEJC/WlYe9VyaG4R5vpu/Zg0=";

  ldflags = [ "-s" "-w" ];

  meta = {
    description = "FIPPF: a Fake-IP Proxy Frontend";
    homepage = "https://github.com/Hyffer/fippf";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ Hyffer ];
    mainProgram = "fippf";
  };
}
