class japsu::env {
  file {
    '/home/japsu/.bash_aliases':
      require => User['japsu'],
      ensure => present,
      source => 'puppet:///modules/japsu/aliases.bash',
      owner => 'japsu',
      group => 'japsu';
  }
}