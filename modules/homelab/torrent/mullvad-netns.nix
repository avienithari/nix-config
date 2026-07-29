{ config, pkgs, secrets, ... }:

let
  private = import "${secrets}/private.nix";
  vpn = private.vpn;
  ip = "${pkgs.iproute2}/bin/ip";
  wg = "${pkgs.wireguard-tools}/bin/wg";
  wgPrivateKeyPath = config.age.secrets.wg-private-key.path;
in
{
  age.secrets."wg-private-key".file =
    "${secrets}/wg-private-key.age";

  systemd.services = {
    netns-mullvad = {
      description = "Mullvad Network Namespace";
      before = [ "network.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        PrivateMounts = false;
        ExecStart = "${ip} netns add mullvad";
        ExecStop = "${ip} netns del mullvad";
      };
    };

    wg-mullvad = {
      description = "Mullvad WireGuard Interface in Namespace";
      bindsTo = [ "netns-mullvad.service" ];
      after = [
        "netns-mullvad.service"
        "network-online.target"
      ];
      wants = [ "network-online.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = pkgs.writers.writeBash "wg-up" ''
          set -e
          ${ip} link add wg-mullvad type wireguard
          ${ip} link set wg-mullvad netns mullvad
          ${ip} -n mullvad link set lo up
          ${ip} -n mullvad address add \
            ${vpn.ip}/32 dev wg-mullvad

          ${ip} netns exec mullvad \
            ${wg} set wg-mullvad \
            private-key ${wgPrivateKeyPath} \
            peer ${vpn.publicKey} \
            allowed-ips 0.0.0.0/0 \
            endpoint ${vpn.endpoint} \
            persistent-keepalive 25

          ${ip} -n mullvad link set wg-mullvad up
          ${ip} -n mullvad route add \
            default dev wg-mullvad
        '';
        ExecStop = pkgs.writers.writeBash "wg-down" ''
          ${ip} -n mullvad link del wg-mullvad || true
        '';
      };
    };
  };

  environment.etc."netns/mullvad/resolv.conf".text = ''
    nameserver ${vpn.dns}
  '';
}
