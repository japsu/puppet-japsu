class japsu::git($email_address='santtu@pajukanta.fi') {
  package {
    [
      'git',
    ]:
      ensure => present;
  }

  file {
    '/home/japsu/.gitconfig':
      ensure => present,
      content => template('japsu/gitconfig.erb'),
      owner => 'japsu',
      group => 'japsu';
  }
}