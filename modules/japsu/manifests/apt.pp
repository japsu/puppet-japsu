class japsu::apt {
  package {
    'apt-file':
      ensure => present;
  }

  exec {
    'apt_file_initial_update':
      require => Package['apt-file'],
      onlyif => "/bin/bash -c '[ -n \"/var/cache/apt/apt-file/*\" ]'",
      command => '/usr/bin/apt-file update';
  }

  file {
    '/etc/apt/apt.conf.d/00jumalauta':
      ensure => present,
      source => 'puppet:///modules/japsu/apt.00jumalauta.conf',
      owner => 'root',
      group => 'root',
      mode => 0644;
  }
}