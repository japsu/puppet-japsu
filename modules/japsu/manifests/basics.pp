class japsu::basics {
  package {
    [
      'acpid',
      'bind9-host',
      'bsdmainutils',
      'build-essential',
      'ca-certificates',
      'curl',
      'dos2unix',
      'htop',
      'less',
      'make',
      'man-db',
      'manpages-dev',
      'ntp',
      'ntpdate',
      'patch',
      'psmisc',
      'pwgen',
      'rsync',
      'screen',
      'subversion',
      'tig',
      'unzip',
      'wget',
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
