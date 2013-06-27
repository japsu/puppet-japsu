class japsu::user {
  group {
    'japsu':
      ensure => present;
  }

  user {
    'japsu':
      gid => 'japsu',
      home => '/home/japsu',
      shell => '/bin/bash',
      managehome => true,
      membership => minimum,
      groups => $operatingsystem ? {
        'Debian' => ['sudo'],
        default => ['sudo'],
      };
  }
}