{ ... }:

{
  programs = {
    # In sync with ~/Projects/nixland/shell/prompt.nix
    starship = {
      enable = true;

      # https://starship.rs/config
      settings = {
        add_newline = true;
        # https://starship.rs/config/#character
        character.success_symbol = "❯";

        crystal.disabled = true;
        dotnet.disabled = true;
        elixir.disabled = true;
        elm.disabled = true;
        erlang.disabled = true;
        java.disabled = true;
        julia.disabled = true;
        nodejs.disabled = true;
        php.disabled = true;

        aws.disabled = true;
        conda.disabled = true;

        directory = {
          fish_style_pwd_dir_length = 1;
          truncation_length = 4;
        };
        git_branch = {
          format = "[$symbol $branch]($style) ";
          symbol = "";
        };

        cmd_duration = {
          format = " ⏳[$duration]($style)";
          show_milliseconds = true;

          min_time = 500; # 500ms
          # Notifications
          show_notifications = true;
          min_time_to_notify = 5000; # 5s
        };
        time = {
          disabled = false;
          format = "[$time]($style)";
          time_format = "%F %a 🕙 %T ";
        };

        # https://starship.rs/config/#prompt
        #
        # 2020-11-03 Tue 🕙 22:21:33  ⏳23s99ms
        # /a/b/c/one/two/three/four  master [✘!] ❯
        # echo "aoeu"
        format = builtins.concatStringsSep "" [
          "$jobs"
          "$battery"
          "$time"
          "$cmd_duration"

          "$line_break"

          "$username"
          "$hostname"

          "$directory"

          # "kubernetes"
          "$git_branch"
          "$git_commit"
          "$git_state"
          "$git_status"
          "$hg_branch"
          # "$docker_context"
          "$package"

          "$golang"
          "$haskell"
          "$python"
          "$ruby"
          "$rust"

          "$terraform"
          "$nix_shell"
          "$memory_usage"
          # "$env_var"

          "$character"

          "$line_break"
          "\n"
        ];
        # right_format = builtins.concatStringsSep "" [
        #   "$cmd_duration"
        # ];
      };
    };
  };
}
