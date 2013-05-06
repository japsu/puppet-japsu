class japsu::env {
  file {
    '/home/japsu/Work':
      ensure => directory,
      owner => 'japsu',
      group => 'japsu';
  }

  vcsrepo {
    '/home/japsu/Work/puppet-japsu':
      ensure => present,
      provider => git,
      source => 'https://github.com/japsu/puppet-japsu.git',
      user => 'japsu',
      owner => 'japsu',
      group => 'japsu';

    # XXX the dotfiles repo should go away
    '/home/japsu/Work/dotfiles':
      ensure => present,
      provider => git,
      source => 'https://github.com/japsu/dotfiles.git',
      user => 'japsu',
      owner => 'japsu',
      group => 'japsu';
  }
}