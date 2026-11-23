{ ... }:

{
  users = {
    groups = {

      "local" = {
        # Users that can unplug the machine
      }; # ..users.groups."local"

      "media" = {
        # Users that manage media
      }; # ..users.groups."media"

    }; # ..users.groups
  }; # ..users
}
