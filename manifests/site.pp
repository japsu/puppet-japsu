File {
  owner => 'root',
  group => 'root',
  mode  => 0644
}

node wasp {
  class {
    'japsu::network::work':
      ip_address => '192.168.56.4';
  }

  include japsu::work

  # x
  include apache
  include php::mod_php

  apache::site {
    'xdev.192.168.56.4.xip.io':
      app_root => '/srv/xdev';
  }
}

node helios {
  include japsu::personal
  include japsu::samba
  include japsu::fstab
}

node lachesis {
  include japsu::personal
  include japsu::irc
  include japsu::fstab
}