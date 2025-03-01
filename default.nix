{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "fippf";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "Hyffer";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-kab8NFFI3YEi2S6hwj0l1Ch6Sg6iRNnyAk6qieM6Scg=";
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
