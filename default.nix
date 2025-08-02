{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "fippf";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "Hyffer";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-ckv1jGwJrzYmJMNzsl/rh+1rbO0N4tGi3kI3MmFnzOM=";
  };

  vendorHash = "sha256-TvjmZfrR3X9gwuxIMG5+xV3p/6kQUZxqfgzUMkR2IHg=";

  ldflags = [ "-s" "-w" ];

  meta = {
    description = "FIPPF: a Fake-IP Proxy Frontend";
    homepage = "https://github.com/Hyffer/fippf";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ Hyffer ];
    mainProgram = "fippf";
  };
}
