class japsu::samba::work {
  # FMH
  package {
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