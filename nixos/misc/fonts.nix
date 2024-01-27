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
    #(nerdfonts.override { fonts = [ "DroidSansMono" ]; })
    (nerdfonts.override { fonts = [ "CascadiaCode" "JetBrainsMono" "FiraCode" ]; })
    carlito
    dejavu_fonts
    emacs-all-the-icons-fonts
    fira-code
    font-awesome
    font-awesome-edited
    font-awesome_5
    fontforge-gtk
    iosevka
    ipafont
    kochi-substitute
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-code-pro
    source-han-sans
    source-han-sans-japanese
    source-han-serif-japanese
    source-sans-pro
    source-serif-pro
    ttf_bitstream_vera
  ];
}
