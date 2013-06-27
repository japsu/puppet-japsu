node wasp {
  class {
    'japsu::network::work':
      ip_address => '192.168.56.4';
  }

  include japsu::work
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
  include japsu::nvm
  include japsu::ssh
  include japsu::vim

  include virtualbox::guest
}