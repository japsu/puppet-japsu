class japsu::basics {
  package {
    [
      'bind9-host',
      'bsdmainutils',
      'ca-certificates',
      'htop',
      'less',
      'man-db',
      'manpages-dev',
      'ntp',
      'ntpdate',
      'patch',
      'pwgen',
      'rsync',
      'screen',
      'subversion',
      'tig',
      'unzip',
      'whois',
      'zip',
    ]:
      ensure => present;
  }

  file {
    # console font
    '/etc/default/console-setup':
      ensure => present,
      owner => 'root',
      group => 'root',
      mode => 0644,
      source => 'puppet:///modules/japsu/console-setup';
  }
}