class japsu::group {
  group {
    'japsu':
      ensure => present,
      gid => 1000;
  }
}

class japsu::user::work {
  include japsu::group

  user {
    'japsu':
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

class japsu::user::personal {
  include japsu::group
  
  # TODO
}