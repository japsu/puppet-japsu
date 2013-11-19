class japsu::ssh {
  file {
    '/home/japsu/.ssh/':
      require => User['japsu'],
      ensure => directory,
      owner => 'japsu',
      group => 'japsu',
      mode => 0700;
    '/home/japsu/.ssh/config':
      require => User['japsu'],
      ensure => present,
      source => 'puppet:///modules/japsu/ssh_config',
      owner => 'japsu',
      group => 'japsu',
      mode => 0600;
  }
}

class japsu::ssh::keys::work {
  ssh_authorized_key {
    'japsu@ishtar-20130506':
      ensure => present,
      key => 'AAAAB3NzaC1yc2EAAAABJQAAAQEAgeKegniJUEmIeAumTcF73lEt4047pOZGuzsukThMjCiiGx1j64O6Px4YRcqXCL33a4p9tHp1iEsujJpEJEMaTdcomzS2bKuFRC/F6kG63TjdoOHzZku+Dyl8B6vC4/+wuNUOKbVus1usHaqa9v4yHE4dkKqVOdse5IpQBgxOoIFbakAbO0oSC98yQVNjOHZ/+ckObMhei4rasckKW74QTNNVO+5H68nvJ4ndY5g3Ky/Dlo78XNfgaJiQvf/vQbDZL6GJgXfVAMiDr+BQaUpF/r3oWhV0IY1hAbS8N8zJmaHt9aNalGPzXdOwGAUxU2QR03JQsHofgjr9s2BD5gIvIw==',
      type => 'ssh-rsa',
      user => 'japsu';
  }
}

class japsu::ssh::keys::personal {
  ssh_authorized_key {
    'japsu@navitas-20130507':
      user => 'japsu',
      ensure => absent;
    'japsu@navitas-20130719':
      ensure => present,
      key => 'AAAAB3NzaC1yc2EAAAABJQAAAQBm2r27t6Z/M5vfiXhjlGBkv94QilQRlwexlipgt+q1CfaKKlBJAS85X5/OJj4ATT9ijh+9Y+p4AYjO3OnwvSKLD6UjQwchEe28RJ1X3o85wJ12TpHXhWWl2rCF0uXrYTJom1fcUyC9eqy55l7M6UT3p7jeYKeFnhyRw4JnN3jAMX839504k/u304Rz7Hwl0aSJ6y9mOdvYzqS52OR0YQBJI4c8CPkdaywAYlCWSzB//M2JSBtm/QKwfKZwmqq8JNc19+Wyzr2sRWG876njbQia2WWlQ42/NbVmsCcuuPuVH3kwcdaIgnQDaqpIqLhs9ydSYYo7Fg83oF9PzHwsM6ct',
      type => 'ssh-rsa',
      user => 'japsu';
    'japsu@arazu-20130507':
      ensure => present,
      key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDUnl7Av8IOOyzOliNQ23+py3OY6jQCQdjTFDTWVCoF7AeX5UpRFwvklP8p7E70ZFwB1oSSfxjJhsHaUQrlhVr1YXGATYdiUZfeI7jqKWLee2olc60X9PJ5t4vYUBGk42rwKed1alaQ7pN5CdGMoy5n4nqOGIXTkSr7P7SSVu5H5/AqwTeeFP3SXeWRsFJqMRf8eArlKjQmC1nY4sRcAAPtpu/Zdhgm/AqGliTjiBLDIrvf1NVOaPbgVZcXwvRHo9V7WbJufl4qZaTYhDrWYfCM3eS1jtKJf5oatD0O1xflnejnuxINbNPE+POD1Co41yh1E9i5dYf5LsXtjUznNFfV',
      type => 'ssh-rsa',
      user => 'japsu';
    'japsu@ishtar-20130507':
      ensure => present,
      key => 'AAAAB3NzaC1yc2EAAAABJQAAAQEAhRRYLAvEVLdkMoLTEhLYvEX4mQOM7SXyF5Efil/0iK+fqxLUudHPC3au+jGzwTvfAVY4pfLdgZtyj9z2l6Q0sTcycAYiZnOC6enCF/aeHdDbe1lfgRZ6ZWPu1hnmFsMJwPsWSERix/x0RU5hJdvKGSFGh1n6KWBLd9Wicr/ab3EtpsIDyQrOK5tz7wMUrHdpsw2N19/RYvWlVg+WSA8Oc4RvPyVg+R4Q80DgwgF9L5LgasYGDDjOUHt9BwzMCwK68NH7WEF6A2OT7Cz+0gcoaVDKQa8dFaPZBL8ZuVOsgKzI5bfk29iTLUvkB71x4fTMplNGhIA75KLAKd+frkxzbw==',
      type => 'ssh-rsa',
      user => 'japsu';
    'japsu@nemesis-20130507':
      ensure => absent,
      user => 'japsu';
    'japsu@proteus-20131119':
      ensure => present,
      key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDLrbcrhiE2tYJQMhgkeTn2OZ37wxkAE36w2y9508L4AtbnihS5Thf+FzJri/cMfvJTBX5cG+ji2jTrakyQ9NLDwq2KeH1EaRmyBXWrQmrOXrcV7HA5yIsddBdw+e3nyglv/LqbhRpQ2TBC/SprM2zkhW2JyYZzDVOYstIavg/qqa2IeyjUZ0Rcxe85r+PaQwumiQ4sLGnsjK+Ktzq1QjjW2O5gH2NhsYR2OY1MDAMFkWS6Ga6ZzWu3E5f4pyk9HLiKJp8Ozv1Hca0x+DzTLB+TsGkg01K2br3932/V9US1abfduIExyhRVw77WV42Z9whjCPj6aSDHU04xaRQSXNwH',
      type => 'ssh-rsa',
      user => 'japsu';
  }
}

class japsu::sshd {
  package {
    [
      'openssh-server',
      'molly-guard'
    ]
      :
      ensure => present;
  }

  file {
    '/etc/ssh/sshd_config':
      require => Package['openssh-server'],
      ensure => present,
      notify => Service['ssh'],
      source => 'puppet:///modules/japsu/sshd_config';
  }

  service {
    'ssh':
      ensure => running,
      enable => true,
      hasstatus => true,
      hasrestart => true;
  }
}