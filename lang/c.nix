{config, pkgs, ...}:

{
  home.packages = with pkgs; [
    cmake
    ninja
  ];
}
