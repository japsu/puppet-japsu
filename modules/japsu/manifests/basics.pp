class japsu::basics {
  package {
    [
      'bsdmainutils',
      'vim',
      'screen',
      'git',
      'git-core',
      'man-db',
      'manpages-dev',
      'rsync',
      'patch',
      'bind9-host',
      'ca-certificates',
      'htop',
      'less',
    ]:
      ensure => present;
  }
}