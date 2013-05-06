class japsu::apt {
  package {
    'apt-file':
      ensure => present;
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