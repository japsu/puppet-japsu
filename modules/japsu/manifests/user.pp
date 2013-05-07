class japsu::user {
  group {
    'japsu':
      ensure => present,
      gid => 1000;
  }

  user {
    'japsu':
      uid => 1000,
      gid => 'japsu',
      home => '/home/japsu',
      managehome => true,
      membership => minimum,
      groups => $operatingsystem ? {
        'Debian' => ['sudo'],
        default => ['sudo'],
      }
  }
}