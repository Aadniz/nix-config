{ pkgs, ... }:
let
  jetbra = pkgs.fetchFromGitHub {
    owner = "LostAttractor";
    repo = "jetbra";
    rev = "94585581c360862eab1843bf7edd8082fdf22542";
    sha256 = "sha256-9jeiF9QS4MCogIowu43l7Bqf7dhs40+7KKZML/k1oWo=";
  };
in
{


  environment.systemPackages = with pkgs.jetbrains; [
    clion
    (datagrip.overrideAttrs (old:{
      postInstall = ''

        # add ja-netfilter
        cd $out/datagrip/bin
        echo '-javaagent:${jetbra}/ja-netfilter.jar=jetbrains' >> datagrip64.vmoptions
        echo '--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED' >> datagrip64.vmoptions
        echo '--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED' >> datagrip64.vmoptions
      '';
    }))

    (phpstorm.overrideAttrs (old:{
      postInstall = ''

        # add ja-netfilter
        cd $out/phpstorm/bin
        echo '-javaagent:${jetbra}/ja-netfilter.jar=jetbrains' >> phpstorm64.vmoptions
        echo '--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED' >> phpstorm64.vmoptions
        echo '--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED' >> phpstorm64.vmoptions
      '';
    }))
    pycharm-professional
    rust-rover
  ];

  #hm.xdg.configFile."JetBrains/template.vmoptions".text = vmoptions;
  #hm.xdg.configFile."JetBrains/IntelliJIdea${pkgs.jetbrains.idea-ultimate.version}/idea64.vmoptions".text = vmoptions;
  #hm.xdg.configFile."JetBrains/PyCharm${pkgs.jetbrains.pycharm-professional.version}/pycharm64.vmoptions".text = vmoptions;
  #hm.xdg.configFile."JetBrains/CLion${pkgs.jetbrains.clion.version}/clion64.vmoptions".text = vmoptions;
  #hm.xdg.configFile."JetBrains/PhpStorm${pkgs.jetbrains.phpstorm.version}/phpstorm64.vmoptions".text = vmoptions;
  #xdg.configFile."JetBrains/RustRover${pkgs.jetbrains.clion.version}/clion64.vmoptions".text = vmoptions;

  # https://jetbra.in/5d84466e31722979266057664941a71893322460
}
