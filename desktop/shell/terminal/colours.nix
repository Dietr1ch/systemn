{ lib, ... }:
let
  themes = {
    # The 16 colors palette used by the virtual consoles. Leave empty to use the
    # default colors. Colors must be in hexadecimal format and listed in order
    #
    # Enable rainbow-mode
    #
    # https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
    # https://search.nixos.org/options?channel=unstable&show=console.colors

    unknown = [
      "#002129" # Black
      "#dc322f" # Red
      "#859900" # Green
      "#b58900" # Yellow
      "#268bd2" # Blue
      "#d33682" # Magenta
      "#2aa198" # Cyan
      "#eee8d5" # White
      "#004050" # Bright Black
      "#cb4b16" # Bright Red
      "#586e75" # Bright Green
      "#657b83" # Bright Yellow
      "#839496" # Bright Blue
      "#6c71c4" # Bright Magenta
      "#93a1a1" # Bright Cyan
      "#fdf6e3" # Bright White
    ];

    # Select themes from https://gogh-co.github.io/Gogh/
    afterglow = [
      "#151515" # Black
      "#A53C23" # Red
      "#7B9246" # Green
      "#D3A04D" # Yellow
      "#6C99BB" # Blue
      "#9F4E85" # Magenta
      "#7DD6CF" # Cyan
      "#D0D0D0" # White
      "#505050" # Bright Black
      "#A53C23" # Bright Red
      "#7B9246" # Bright Green
      "#D3A04D" # Bright Yellow
      "#547C99" # Bright Blue
      "#9F4E85" # Bright Magenta
      "#7DD6CF" # Bright Cyan
      "#F5F5F5" # Bright White
    ];
    darkside = [
      "#000000" # Black
      "#E8341C" # Red
      "#68C256" # Green
      "#F2D42C" # Yellow
      "#1C98E8" # Blue
      "#8E69C9" # Magenta
      "#1C98E8" # Cyan
      "#BABABA" # White
      "#000000" # Bright Black
      "#E05A4F" # Bright Red
      "#77B869" # Bright Green
      "#EFD64B" # Bright Yellow
      "#387CD3" # Bright Blue
      "#957BBE" # Bright Magenta
      "#3D97E2" # Bright Cyan
      "#BABABA" # Bright White
    ];
    hybrid = [
      "#282A2E" # Black
      "#A54242" # Red
      "#8C9440" # Green
      "#DE935F" # Yellow
      "#5F819D" # Blue
      "#85678F" # Magenta
      "#5E8D87" # Cyan
      "#969896" # White
      "#373B41" # Bright Black
      "#CC6666" # Bright Red
      "#B5BD68" # Bright Green
      "#F0C674" # Bright Yello
      "#81A2BE" # Bright Blue
      "#B294BB" # Bright Magen
      "#8ABEB7" # Bright Cyan
      "#C5C8C6" # Bright White
    ];
  };
in
{
  console = {
    colors = map (lib.strings.removePrefix "#") themes.afterglow;
  };
}
