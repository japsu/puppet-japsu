node wasp {
  class {
    'japsu::network::work':
      ip_address => '192.168.56.4';
  }

  include japsu::work
}