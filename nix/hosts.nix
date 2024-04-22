let
  hasSuffix = suffix: content:
    let
      inherit (builtins) stringLength substring;
      lenContent = stringLength content;
      lenSuffix = stringLength suffix;
    in
    lenContent >= lenSuffix
    && substring (lenContent - lenSuffix) lenContent content == suffix
  ;

  mkHost =
    { type
    , hostPlatform
    , address ? null
    , pubkey ? null
    , homeDirectory ? null
    , remoteBuild ? true
    , large ? false
    }:
    if type == "nixos" then
      assert address != null && pubkey != null;
      assert (hasSuffix "linux" hostPlatform);
      {
        inherit type hostPlatform address pubkey remoteBuild large;
      }
    else if type == "darwin" then
      assert pubkey != null;
      assert (hasSuffix "darwin" hostPlatform);
      {
        inherit type hostPlatform pubkey large;
      }
    else if type == "home-manager" then
      assert homeDirectory != null;
      {
        inherit type hostPlatform homeDirectory large;
      }
    else throw "unknown host type '${type}'";
in
{
  crius = mkHost {
    type = "darwin";
    hostPlatform = "x86_64-darwin";
    pubkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGMw0NKPWSAYBnCmhW2XF3EVMu28eG2Ukq+15NCYm9kSqMN45w0vfHYmBRlVe6ANuZgORpNaHt/prRnIwiKEkLCSjcaRV0QAWKoL/VvCOd5DRj1g37yALhYQTc7FHvwv4RLnmNhX/OUHTAa5kHuWXX+vp2Aj5lOj9aAQk/tbEyVfcWOwLrG/3RTLHoYgEEw3sBN+m2inj1CO2i2GQJzYdoBJ1NiFUwATaRVB7PHssQD70flZbZY3FJNMfKWU/9rStvnQlS/F6QylrVHs0If2W2FZeRtqG6364nBueDod51R+brRY1A4C4+9rbdbC02O8XC0ytdlJmOi58pxNRWrx3T6SBuO3sDAgDZr5rhCqyFBYxRfoQ4/C5cCWHC4rXweW0pPfXk87jjwLPuFcOsDaMch16+syIXgSCsW5c+FC7gI1xSjrQMXad4P6Sj3va1ybtCYuRITaX2JTlr5eYb2oQpucjR0XEa0g1rBL0Z6MpCRGmbfZYnOjRgF67EfzQrxxk=";
  };
}
