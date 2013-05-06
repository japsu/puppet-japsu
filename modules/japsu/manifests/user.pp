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

  ssh_authorized_key {
    'japsu@ishtar-20130506':
      ensure => present,
      key => 'AAAAB3NzaC1yc2EAAAABJQAAAQEAgeKegniJUEmIeAumTcF73lEt4047pOZGuzsukThMjCiiGx1j64O6Px4YRcqXCL33a4p9tHp1iEsujJpEJEMaTdcomzS2bKuFRC/F6kG63TjdoOHzZku+Dyl8B6vC4/+wuNUOKbVus1usHaqa9v4yHE4dkKqVOdse5IpQBgxOoIFbakAbO0oSC98yQVNjOHZ/+ckObMhei4rasckKW74QTNNVO+5H68nvJ4ndY5g3Ky/Dlo78XNfgaJiQvf/vQbDZL6GJgXfVAMiDr+BQaUpF/r3oWhV0IY1hAbS8N8zJmaHt9aNalGPzXdOwGAUxU2QR03JQsHofgjr9s2BD5gIvIw==',
      name => 'japsu@ishtar-20130506',
      type => 'ssh-rsa',
      user => 'japsu';
  }
}

class japsu::user::personal {
  include japsu::group
  
  # TODO
}