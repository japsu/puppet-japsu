class japsu::nvm {
  file {
    '/home/japsu/System':
      ensure => directory,
      owner => 'japsu',
      group => 'japsu',
      mode => 0755;
  }

  vcsrepo {
    '/home/japsu/System/nvm':
      ensure => present,
      provider => git,
      source => 'https://github.com/creationix/nvm.git',
      user => 'japsu',
      owner => 'japsu',
      group => 'japsu';
  }
}