class japsu::apt {
  package {
    'apt-file':
      ensure => present;
  }

  exec {
    'apt_file_initial_update':
      require => Package['apt-file'],
      creates => '/var/cache/apt/apt-file/.apt_file_initial_update',
      command =>
        '/usr/bin/apt-file update && /usr/bin/touch /var/cache/apt/apt-file/.apt_file_initial_update';
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