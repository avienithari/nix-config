{ secrets, ... }:

let
  private = import "${secrets}/private.nix";
  domain = private.acme.domain;
in
{
  networking = {
    nameservers = [ "127.0.0.1" ];
    networkmanager.insertNameservers = [ ];
    firewall = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 ];
    };
  };

  services = {
    adguardhome = {
      enable = true;
      openFirewall = true;
      host = "127.0.0.1";
      port = 8082;

      settings = {
        theme = "dark";
        dns = {
          bind_hosts = [ "0.0.0.0" ];
          port = 53;
          upstream_dns = [
            "https://dns.quad9.net/dns-query"
            "https://cloudflare-dns.com/dns-query"
          ];

          bootstrap_dns = [
            "9.9.9.9"
            "1.1.1.1"
          ];
        };

        filters = [
          {
            enabled = true;
            url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
            name = "StevenBlack Hosts (Pi-hole Default)";
            id = 1;
          }
          {
            enabled = true;
            url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt";
            name = "Adguard DNS filter";
            id = 2;
          }
          {
            enabled = true;
            url = "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt";
            name = "Firebog Suspicious List";
            id = 3;
          }
          {
            enabled = true;
            url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts";
            name = "Firebog Suspicious List";
            id = 4;
          }
          {
            enabled = true;
            url = "https://v.firebog.net/hosts/static/w3kbl.txt";
            name = "Firebog Suspicious List";
            id = 5;
          }
          {
            enabled = true;
            url = "https://adaway.org/hosts.txt";
            name = "Firebog Advertising List";
            id = 6;
          }
          {
            enabled = true;
            url = "https://v.firebog.net/hosts/AdguardDNS.txt";
            name = "Firebog Advertising List";
            id = 7;
          }
          {
            enabled = true;
            url = "https://v.firebog.net/hosts/Admiral.txt";
            name = "Firebog Advertising List";
            id = 8;
          }
          {
            enabled = true;
            url = "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt";
            name = "Firebog Advertising List";
            id = 9;
          }
          {
            enabled = true;
            url = "https://v.firebog.net/hosts/Easylist.txt";
            name = "Firebog Advertising List";
            id = 10;
          }
          {
            enabled = true;
            url = "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext";
            name = "Firebog Advertising List";
            id = 11;
          }
          {
            enabled = true;
            url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts";
            name = "Firebog Advertising List";
            id = 12;
          }
          {
            enabled = true;
            url = "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts";
            name = "Firebog Advertising List";
            id = 13;
          }
          {
            enabled = true;
            url = "https://v.firebog.net/hosts/Easyprivacy.txt";
            name = "Firebog Tracking & Telemetry List";
            id = 14;
          }
          {
            enabled = true;
            url = "https://v.firebog.net/hosts/Prigent-Ads.txt";
            name = "Firebog Tracking & Telemetry List";
            id = 15;
          }
          {
            enabled = true;
            url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts";
            name = "Firebog Tracking & Telemetry List";
            id = 16;
          }
          {
            enabled = true;
            url = "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt";
            name = "Firebog Tracking & Telemetry List";
            id = 17;
          }
          {
            enabled = true;
            url = "https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt";
            name = "Firebog Tracking & Telemetry List";
            id = 18;
          }
          {
            enabled = true;
            url = "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt";
            name = "Firebog Malicious List";
            id = 19;
          }
          {
            enabled = true;
            url = "https://v.firebog.net/hosts/Prigent-Crypto.txt";
            name = "Firebog Malicious List";
            id = 20;
          }
          {
            enabled = true;
            url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts";
            name = "Firebog Malicious List";
            id = 21;
          }
          {
            enabled = true;
            url = "https://phishing.army/download/phishing_army_blocklist_extended.txt";
            name = "Firebog Malicious List";
            id = 22;
          }
          {
            enabled = true;
            url = "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt";
            name = "Firebog Malicious List";
            id = 23;
          }
          {
            enabled = true;
            url = "https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt";
            name = "Firebog Malicious List";
            id = 24;
          }
          {
            enabled = true;
            url = "https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/hosts";
            name = "Firebog Malicious List";
            id = 25;
          }
          {
            enabled = true;
            url = "https://urlhaus.abuse.ch/downloads/hostfile/";
            name = "Firebog Malicious List";
            id = 26;
          }
          {
            enabled = true;
            url = "https://lists.cyberhost.uk/malware.txt";
            name = "Firebog Malicious List";
            id = 27;
          }
          {
            enabled = true;
            url = "https://hole.cert.pl/domains/v2/domains.txt";
            name = "CERT";
            id = 28;
          }
        ];
      };
    };

    caddy.virtualHosts."guard.${domain}" = {
      useACMEHost = domain;
      extraConfig = ''
        reverse_proxy 127.0.0.1:8082
      '';
    };
  };
}
