{ pkgs, ... }:
{
  programs.gpg = {
    enable = true;

    # Have GPG database being managed by the user.
    mutableKeys = true;
    mutableTrust = true;

    settings = {
      charset = "utf=8";
      default-key = "0x49593BD010DE4723";
      no-emit-version = true;
      no-comments = true;
      keyid-format = "0xlong";
      with-fingerprint = true;
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      use-agent = true;
      keyserver = "keys.openpgp.org";
      keyserver-options = [
        "no-honor-keyserver-url"
        "include-revoked"
      ];
      personal-cipher-preferences = [
        "AES256"
        "AES192"
        "AES"
        "CAST5"
      ];
      personal-digest-preferences = [
        "SHA512"
        "SHA384"
        "SHA256"
        "SHA224"
      ];
      cert-digest-algo = "SHA512";
      s2k-digest-algo = "SHA512";
      default-preference-list = [
        "SHA512"
        "SHA384"
        "SHA256"
        "SHA224"
        "AES256"
        "AES192"
        "AES"
        "CAST5"
        "ZLIB"
        "BZIP2"
        "ZIP"
        "Uncompressed"
      ];
    };

    scdaemonSettings = {
      # Tweak GPG's own smart card daemon in order to play nice with pcscd.
      # Essentially, scdaemon shall not try to acquirer an exclusive lock and
      # this will conflict with pcscd, which tries to do the same.
      # Luckily, scdaemon support sharing access with pcscd.
      disable-ccid = true;
      pcsc-shared = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentry = {
      package = pkgs.pinentry-all;
      program = "pinentry";
    };

    enableBashIntegration = true;
    enableFishIntegration = true;

    enableScDaemon = true;
    enableSshSupport = true;

    # Cache passphrase for the given TTL in seconds.
    # Extend the cache lifetime on cache hits.
    defaultCacheTtl = 60 * 60;
    defaultCacheTtlSsh = 60 * 60;

    # Maximum cache TTL beyond which it cannot be extended.
    maxCacheTtl = 60 * 60 * 8;
    maxCacheTtlSsh = 60 * 60 * 8;
  };
}
