{ config, lib, pkgs, ... }:
let
  # Define the custom font package
  customFont = pkgs.stdenv.mkDerivation {
    name = "custom-font";
    src = ./fontawesome-edited.ttf ; # Path to your custom font file
    unpackPhase = ":";
    installPhase = ''
      mkdir -p $out/share/fonts
      cp $src $out/share/fonts/fontawesome-edited.ttf
    '';
    meta = with pkgs.lib; {
      description = "Your custom font";
      license = licenses.mit; # Adjust this to match your font's license
    };
  };

  # Define a script to merge fonts
  mergeFontsScript = pkgs.writeShellScriptBin "merge-fonts" ''
    #!/usr/bin/env bash
    set -euo pipefail

    FONTFORGE_COMMANDS=$(mktemp)
    #echo "Open(\"$1\"); MergeFonts(\"$2\"); SetFontNames(\"Font-Awesome-6-Edited\", \"Font-Awesome-6-Edited\", \"Font-Awesome-6-Edited\"); Generate(\"$3\")" > "$FONTFORGE_COMMANDS"
    echo "Open(\"$1\"); MergeFonts(\"$2\"); SetFontNames(\"Font-Awesome-6-Edited\", \"Font-Awesome-6-Edited\", \"Font-Awesome-6-Edited\"); SetTTFName(0x409, 1, \"Font Awesome 6 Edited\"); SetTTFName(0x409, 2, \"Regular\"); Generate(\"$3\")" > "$FONTFORGE_COMMANDS"
    fontforge -script "$FONTFORGE_COMMANDS"
    rm "$FONTFORGE_COMMANDS"
  '';

  # Define the merged font package
  mergedFont = pkgs.stdenv.mkDerivation {
    name = "merged-font";
    buildInputs = [ pkgs.fontforge ];
    builder = pkgs.writeScript "builder.sh" ''
      source $stdenv/setup
      mkdir -p $out/share/fonts
      ${mergeFontsScript}/bin/merge-fonts ${pkgs.emacs-all-the-icons-fonts}/share/fonts/all-the-icons/fontawesome.ttf ${customFont}/share/fonts/fontawesome-edited.ttf $out/share/fonts/fontawesome-edited.ttf
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
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
    mergedFont
  ];
}
