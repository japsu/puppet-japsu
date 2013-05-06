class japsu::work {
  include japsu::apt
  include japsu::basics
  include japsu::work::samba
}

class japsu::work::network($ip_address='192.168.56.2') {
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

class japsu::work::samba {
  class {
    'samba::server':
      workgroup            => 'WORKGROUP',
      server_string        => 'Virtual Machine for Work',
      netbios_name         => "$hostname",
      interfaces           => [ 'lo', 'eth1' ],
      hosts_allow          => [ '127.', '192.168.56.' ],
      local_master         => 'no',
      map_to_guest         => 'Bad User',
      os_level             => '50',
      preferred_master     => 'no',
      shares => {
          'work' => [
              'comment = Work',
              'writable = yes',
              'guest ok = no',
              'valid users = japsu',
          ],
      },
      selinux_enable_home_dirs => true;
  }
}