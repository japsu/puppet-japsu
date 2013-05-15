class japsu::samba::work {
  package {
    # smbpasswd
    'samba-common-bin':
      ensure => present;
  }

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
      extra_global_options => [
        'load printers = no',
        'printing = BSD',
        'printcap name = /dev/null',
      ],
      shares => {
        'work' => [
          'path = /home/japsu/Work',
          'comment = Work',
          'writable = yes',
          'guest ok = no',
          'valid users = japsu',
        ],
      }
  }
}