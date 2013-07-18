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
      ensure => present,
      source => 'puppet:///modules/japsu/oidentd.conf';
  }
}