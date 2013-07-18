class japsu::irc {
  package {
    [
      'irssi',
      'oidentd'
    ]:
      ensure => installed;
  }

  file {
    '/etc/oidentd.conf':
      require => Package['oidentd'],
      notify => Service['oidentd'],
      ensure => present,
      source => 'puppet:///modules/japsu/oidentd.conf';
  }

  service {
    'oidentd':
      ensure => running,
      enable => true,
      hasrestart => true,
      hasstatus => false;
  }
}