class japsu::git($email_address='santtu@pajukanta.fi') {
  package {
    [
      'git',
    ]:
      ensure => present;
  }

  $git_push_default_behaviour = $::operatingsystem ? {
    'Ubuntu' => $::operatingsystemrelease ? {
      '12.04' => 'tracking',
      default => 'simple'
    },
    'Debian' => 'tracking',
    default => 'simple'
  }

  file {
    '/home/japsu/.gitconfig':
      ensure => present,
      content => template('japsu/gitconfig.erb'),
      owner => 'japsu',
      group => 'japsu';
  }
}
