class japsu::basics {
  package {
    [
      'bind9-host',
      'bsdmainutils',
      'ca-certificates',
      'git',
      'git-core',
      'htop',
      'less',
      'man-db',
      'manpages-dev',
      'patch',
      'pwgen',
      'rsync',
      'screen',
      'tig',
      'vim',
    ]:
      ensure => present;
  }
}