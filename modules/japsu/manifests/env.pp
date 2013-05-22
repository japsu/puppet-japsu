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
    # XXX the dotfiles repo should go away
    '/home/japsu/Work/dotfiles':
      ensure => absent,
      force => true;
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