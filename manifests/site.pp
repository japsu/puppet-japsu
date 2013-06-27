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

  include japsu::work
  include japsu::ssh::keys::personal
}