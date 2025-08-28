{ ... }:

{
  security = {
    pam = {
      # Resource limits
      #
      # Define resource limits that should apply to users or groups. Each item
      # in the list should be an attribute set with a domain, type, item, and
      # value attribute. The syntax and semantics of these attributes must be
      # that described in `limits.conf(5)`
      #
      # Note that these limits do not apply to systemd services, whose limits
      # can be changed via systemd.extraConfig instead.
      #
      # https://search.nixos.org/options?channel=unstable&query=security.pam.loginLimits
      loginLimits = [
        # core :: limits the core file size (KB)
        # data :: maximum data size (KB)
        # fsize :: maximum filesize (KB)
        # memlock :: maximum locked-in-memory address space (KB)
        {
          domain = "*";
          type = "soft";
          item = "memlock";
          value = "4096";
        } # 4MB
        {
          domain = "*";
          type = "hard";
          item = "memlock";
          value = "65536";
        } # 64M
        # nofile :: maximum number of open file descriptors
        # stack :: maximum stack size (KB)
        # cpu :: maximum CPU time (minutes)
        # nproc :: maximum number of processes
        {
          domain = "*";
          type = "soft";
          item = "nproc";
          value = "4096";
        }
        {
          domain = "*";
          type = "hard";
          item = "nproc";
          value = "16384";
        }
        # as :: address space limit (KB)
        # maxlogins :: maximum number of logins for this user (this limit does not apply to user with uid=0)
        # maxsyslogins :: maximum number of all logins on system; user is not allowed to log-in if total number of all user logins is greater than specified number (this limit does not apply to user with uid=0)
        # nonewprivs :: value of 0 or 1; if set to 1 disables acquiring new privileges by invoking prctl(PR_SET_NO_NEW_PRIVS)
        # priority :: the priority to run user process with (negative values boost process priority)
        # locks :: maximum locked files
        # sigpending :: maximum number of pending signals
        # msgqueue :: maximum memory used by POSIX message queues (bytes)
        # nice :: maximum nice priority allowed to raise to. values: [-20,19]
        # rtprio :: maximum realtime priority allowed for non-privileged processes
      ];
    };
  };
}
