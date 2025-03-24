{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "fippf";
  version = "0.2.0a";

  src = fetchFromGitHub {
    owner = "Hyffer";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-0Z87iijF616h+qhdWpZl2Z6Vjkc3L6RddBf2576XS0Y=";
  };

  vendorHash = "sha256-LnIrjTH0aJoErF1112eAlnRKd0J7JjnH1BHEU0/GuSU=";

  ldflags = [ "-s" "-w" ];

  meta = {
    description = "FIPPF: a Fake-IP Proxy Frontend";
    homepage = "https://github.com/Hyffer/fippf";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ Hyffer ];
    mainProgram = "fippf";
  };
}
