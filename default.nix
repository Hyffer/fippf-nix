{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "fippf";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "Hyffer";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-fTpi7yuYr1LTdhsjgc2faKrIzYMU0wRO9U58igEnIPE=";
  };

  vendorHash = "sha256-40dJKdQDBEU0yfR7yWo020CV3LiioSXCyDkQcTM+KEM=";

  ldflags = [ "-s" "-w" ];

  meta = {
    description = "FIPPF: a Fake-IP Proxy Frontend";
    homepage = "https://github.com/Hyffer/fippf";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ Hyffer ];
    mainProgram = "fippf";
  };
}
