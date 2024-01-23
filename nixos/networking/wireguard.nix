{ config, lib, pkgs, ... }:

{
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "172.17.227.242/32"  ];
      dns = [ "46.227.67.134" "192.165.9.158" ];
      privateKeyFile = "/etc/wireguard/private.key";

      peers = [
        {
          publicKey = "BH/TUFM8TPoYqpry4o2ZF+rgW3DPTZHsB886Wq6aaCc=";
          allowedIPs = [ "0.0.0.0/0"  ];
          endpoint = "vpn43.prd.zurich.ovpn.com:9929";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
