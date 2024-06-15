{ pconf, ... }: let
in {
  accounts.email.accounts = {
    work = {
      primary = true;
      address = pconf.work;
      realName = pconf.name;
      userName = pconf.work;
      passwordCommand = "...";
      imap = {
        host = pconf.imap;
        tls.enable = true;
      };
      smtp = {
        host = pconf.smtp;
        tls.enable = true;
      };
    };
  };
  accounts.calendar.accounts = {
    work = {
      primary = true;
      remote = {
        type = "caldav";
        url = "https://purelymail.com";
        userName = pconf.work;
        passwordCommand = "...";
      };
    };
  };
  accounts.contact.accounts = {
    work = {
      primary = true;
      remote = {
        type = "carddav";
        url = "https://purelymail.com";
        userName = pconf.work;
        passwordCommand = "...";
      };
    };
  };
}
