class japsu::samba {
  package {
    # smbpasswd
    'samba-common-bin':
      ensure => present;
  }
}

class japsu::samba::work {
  include japsu::samba
  
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

class japsu::samba::helios {
  include japsu::samba

  class {
    'samba::server':
      workgroup            => 'OURSULAERT',
      server_string        => 'Covert Ops Frigate',
      netbios_name         => "$hostname",
      interfaces           => [ 'lo', 'eth0' ],
      hosts_allow          => [ '127.', '192.168.1.' ],
      local_master         => 'yes',
      map_to_guest         => 'Bad User',
      os_level             => '50',
      preferred_master     => 'yes',
      extra_global_options => [
        'load printers = no',
        'printing = BSD',
        'printcap name = /dev/null',
      ],
      shares => {
        'work' => [
          'path = /srv/work',
          'comment = Work',
          'writable = yes',
          'guest ok = no',
          'valid users = japsu',
        ],
        'incoming' => [
          'path = /srv/incoming',
          'comment = Incoming',
          'writable = yes',
          'guest ok = no',
          'valid users = japsu',
        ],
        'media' => [
          'path = /srv/media',
          'comment = Media',
          'writable = yes',
          'guest ok = no',
          'valid users = japsu',
        ],
        'photos' => [
          'path = /srv/photos',
          'comment = Photos',
          'writable = yes',
          'guest ok = no',
          'valid users = japsu',
        ],
      }
  }
}