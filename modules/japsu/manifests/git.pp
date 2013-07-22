class japsu::git($email_address='santtu@pajukanta.fi') {
  package {
    [
      'git',
    ]:
      ensure => present;
  }

  $git_push_default_behaviour = $::operatingsystem ? {
    'Ubuntu' => 'simple',
    'Debian' => 'tracking'
  }

  file {
    '/home/japsu/.gitconfig':
      ensure => present,
      content => template('japsu/gitconfig.erb'),
      owner => 'japsu',
      group => 'japsu';
  }
}