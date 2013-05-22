class japsu::env {
  file {
    '/home/japsu/Work':
      require => User['japsu'],
      ensure => directory,
      owner => 'japsu',
      group => 'japsu';
    '/home/japsu/.bash_aliases':
      require => User['japsu'],
      ensure => present,
      source => 'puppet:///modules/japsu/aliases.bash',
      owner => 'japsu',
      group => 'japsu';
  }

  vcsrepo {
    '/home/japsu/Work/puppet-japsu':
      require => User['japsu'],
      ensure => present,
      provider => git,
      source => 'https://github.com/japsu/puppet-japsu.git',
      user => 'japsu',
      owner => 'japsu',
      group => 'japsu';
  }
}