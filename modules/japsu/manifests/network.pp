class japsu::network::work($ip_address='192.168.56.2') {
  augeas { "host_only_networking":
    context => "/files/etc/network/interfaces",
    changes => [
      "set auto[child::1 = 'eth1']/1 eth1",
      "set iface[. = 'eth1'] eth1",
      "set iface[. = 'eth1']/family inet",
      "set iface[. = 'eth1']/method static",
      "set iface[. = 'eth1']/address $ip_address",
      "set iface[. = 'eth1']/netmask 255.255.255.0",
      "set iface[. = 'eth1']/network 192.168.56.0",
    ];
  }
}