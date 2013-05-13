class japsu::apt {
  package {
    'apt-file':
      ensure => present;
  }

  exec {
    'apt_file_initial_update':
      require => Package['apt-file'],
      unless => 'ls /var/cache/apt/apt-file | grep -q Contents',
      command => 'apt-file update',
      provider => 'shell';
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