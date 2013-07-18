File {
  owner => 'root',
  group => 'root'
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

node valkyrie {
  class {
    'japsu::network::work':
      ip_address => '192.168.56.100';
  }

  include japsu::apt
  include japsu::basics
  include japsu::env
  include japsu::git
  include japsu::samba::work
  include japsu::user
  include japsu::sudo::nopasswd
  include japsu::ruby
  include japsu::ssh
  include japsu::vim

  include nvm

  nvm::user_nvm {
    'japsu':
      autoload => true;
  }
  
  nvm::user_node {
    'japsu/v0.10.12':
      set_as_default => true;
  }

  include virtualbox::guest
}

node helios {
  include japsu::personal

  file {
    '/etc/fstab':
      ensure => present,
      source => 'puppet:///modules/japsu/fstab@helios';
  }
}