{ config, secrets, ... }:

let
  lanDomainTokenPath = config.age.secrets.cloudflare-lan-domain-token.path;

  private = import "${secrets}/private.nix";
  domain = private.services.acme.domain;
  email = private.services.acme.email;
in
{
  age.secrets."cloudflare-lan-domain-token" = {
    file = "${secrets}/cloudflare-lan-domain-token.age";
    owner = "acme";
    group = "acme";
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = email;

    certs."${domain}" = {
      domain = "*.${domain}";
      extraDomainNames = [ "${domain}" ];
      dnsProvider = "cloudflare";

      credentialFiles = {
        "CLOUDFLARE_DNS_API_TOKEN_FILE" = lanDomainTokenPath;
      };
    };
  };
}
