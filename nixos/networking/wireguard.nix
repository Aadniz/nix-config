{ config, lib, pkgs, ... }:
let
  interfaces = [ "waydroid0" ];
  script = pkgs.writeShellScriptBin "setup-routing" ''
    for interface in ${toString interfaces}; do
      # Mark packets from the interface
      ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT -o $interface -j MARK --set-mark 0x2
    done

    # Add a default route for marked packets
    ${pkgs.iproute}/bin/ip route add default via 192.168.111.1 dev enp38s0 table 200

    # Add a rule to use the 200 table for marked packets
    ${pkgs.iproute}/bin/ip rule add fwmark 0x2 table 200
  '';
in
{
  boot.kernel.sysctl."net.ipv4.conf.all.src_valid_mark" = 1;
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "172.17.227.242/32"  ];
      dns = [ "46.227.67.134" "192.165.9.158" ];
      privateKeyFile = "/etc/wireguard/private.key";
      postUp = "${script}/bin/setup-routing";
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
