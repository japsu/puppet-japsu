node wasp {
  class {
    'japsu::work::network':
      ip_address => '192.168.56.4';
  }

  include japsu::work
}