{ config, lib, pkgs, ... }:
let
  # Define the custom font package
  patchFont = pkgs.stdenv.mkDerivation {
    name = "font-awesome-edited";
    src = ./fontawesome-edited.ttf ;
    unpackPhase = ":";
    installPhase = ''
      mkdir -p $out/share/fonts
      cp $src $out/share/fonts/fontawesome-edited.ttf
    '';
    meta = with pkgs.lib; {
      description = "Edited alter to Font Awesome 6 Free";
    };
  };

  # Merging the fonts into a new one
  mergeFontsScript = pkgs.writeShellScriptBin "merge-fonts" ''
    #!/usr/bin/env bash
    set -euo pipefail

    FONTFORGE_COMMANDS=$(mktemp)

    cat > "$FONTFORGE_COMMANDS" << EOF
        Open("$1");
        MergeFonts("$2");
        SetFontNames("Font-Awesome-6-Edited", "Font-Awesome-6-Edited", "Font-Awesome-6-Edited");
        SetTTFName(0x409, 1, "Font Awesome 6 Edited");
        SetTTFName(0x409, 2, "Regular");
        Generate("$3");
    EOF

    fontforge -script "$FONTFORGE_COMMANDS"
    rm "$FONTFORGE_COMMANDS"
  '';

  # TODO: kind of stupid to use emacs-all-the-icons-fonts here
  font-awesome-edited = pkgs.stdenv.mkDerivation {
    name = "merged-font";
    buildInputs = [ pkgs.fontforge ];
    builder = pkgs.writeScript "builder.sh" ''
      source $stdenv/setup
      mkdir -p $out/share/fonts
      ${mergeFontsScript}/bin/merge-fonts ${pkgs.emacs-all-the-icons-fonts}/share/fonts/all-the-icons/fontawesome.ttf ${patchFont}/share/fonts/fontawesome-edited.ttf $out/share/fonts/fontawesome-edited.ttf
    '';
  };
in
{

  fonts.packages = with pkgs; [
    fira-code
    font-awesome
    iosevka
    source-sans-pro
    source-serif-pro
    #(nerdfonts.override { fonts = [ "DroidSansMono" ]; })
    font-awesome_5
    (nerdfonts.override { fonts = [ "CascadiaCode" "JetBrainsMono" "FiraCode" ]; })
    emacs-all-the-icons-fonts
    ipafont
    kochi-substitute
    fontforge-gtk
    font-awesome-edited
    carlito
    dejavu_fonts
    ipafont
    kochi-substitute
    source-code-pro
    ttf_bitstream_vera
  ];
}
