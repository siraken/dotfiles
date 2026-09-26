# Jujutsu. Split out of the git module so the `base` profile (production
# servers) gets git without it.
{ userProfile, ... }:
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = userProfile.email;
        name = userProfile.name;
      };
    };
  };
}
