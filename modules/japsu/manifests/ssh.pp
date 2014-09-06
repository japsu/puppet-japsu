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
      ensure => absent,
      user => 'japsu';
    'japsu@ishtar-20140107':
      ensure => present,
      key => 'AAAAB3NzaC1yc2EAAAABJQAAAQEAkoWAjItp6IWA4S/rx9QvstnlnsHvlhEZNRth4STyfB70vOzf2k/PQShkVgcQczK8aHZIlksTYm3zJ+bO4Fkb8b2+nnF0MDCiRgiVbBRSvaKEKi/bM2Q7crnvmf9Sw9E5MOSsolV9S3XK0T3uXjyJc5x+m9F0GmuKg5OT+QkKGPiZ4GeqeqXJm4Dl89gEBZRAaGMUJXOBzEKhxcTBMYHQMELIDUt/qY3ZQmMzpTSGxKPbu39ZU46ujYUseTn7saU0LroFKh+xCRK6qxSlVkh2m5juvseYaEhzk707RJoYkdDKRbuGcoxMvCRYsdunvg/bT3LzBSoi4OeoKu1mrztHnw==',
      type => 'ssh-rsa',
      user => 'japsu';
  }
}

class japsu::ssh::keys::personal {
  ssh_authorized_key {
    'japsu@navitas-20130507':
      user => 'japsu',
      ensure => absent;
    'japsu@ishtar-20130507':
      ensure => absent,
      user => 'japsu';
    'japsu@nemesis-20130507':
      ensure => absent,
      user => 'japsu';
    'japsu@keres-20140123':
      ensure => absent,
      user => 'japsu';
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
    'japsu@proteus-20131119':
      ensure => present,
      key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDLrbcrhiE2tYJQMhgkeTn2OZ37wxkAE36w2y9508L4AtbnihS5Thf+FzJri/cMfvJTBX5cG+ji2jTrakyQ9NLDwq2KeH1EaRmyBXWrQmrOXrcV7HA5yIsddBdw+e3nyglv/LqbhRpQ2TBC/SprM2zkhW2JyYZzDVOYstIavg/qqa2IeyjUZ0Rcxe85r+PaQwumiQ4sLGnsjK+Ktzq1QjjW2O5gH2NhsYR2OY1MDAMFkWS6Ga6ZzWu3E5f4pyk9HLiKJp8Ozv1Hca0x+DzTLB+TsGkg01K2br3932/V9US1abfduIExyhRVw77WV42Z9whjCPj6aSDHU04xaRQSXNwH',
      type => 'ssh-rsa',
      user => 'japsu';
    'japsu@ishtar-20140103':
      ensure => present,
      key => 'AAAAB3NzaC1yc2EAAAABJQAAAQEAqCL13GZ/DVcR5F+fMMZz6aj8KAxdb6UB2FF/iCX0l5lYK/9lYtHCyEDNpwh/BjfbXocPB5z6PVD4FCJ8Aflgk/JrIiAXmqCOdpMlNihHO8oxvWWzGwcZDozgI+8U0umSfp1N+7RWHcyD+j65Fg7ac9AczHzGhHkCuVgatdgb5U39TMclMt1K6ndxEA/gzx7AwramKm6i/4HfM05kA2LazwTL1s7bAeu+z+vX6eKGEv10bbDaRcuU5BeASkB69eM37cd4ZynbH+14giZHPRb1x3rpmdu5fCMdnyJrDFZHmjyCvLelLgYcSPzSF5W1B302VZTLevOTyLNeECt+KdH3xw==',
      type => 'ssh-rsa',
      user => 'japsu';
    'japsu@keres-20140213':
      ensure => present,
      key => 'AAAAB3NzaC1yc2EAAAABJQAAAQEA8Q4J9EvM4PHi3xrLnHjD/K8GnVBKc2trOEVjYleEEfheMPWoVr1ClPHoCSgEooyQYESe+HywOWGyi68j/gOHVDVavWTuWI5CcSjO7SQltF/0SdIEC03Ztyn5hOGiT+LNTE0BViT57B0g/L1L6QhgN0G0yxfVSS10HjfpIh2VpZFD6UthAZ9JrmsY3CBs6er26U3WJSUVHAp2msef9qKhrcFA0Q++lIEmTRlyZ7qg7YK6q1tGj51Gv+Yu/T/4mCFTAwlVtvDQT6IU2swIUzdlWjQbVMvC+WhiLMxFvsCJH2ChLTbFfQm4SufYxP/VG3HW85oWMFkCRf/w9jFwuClG+w==',
      type => 'ssh-rsa',
      user => 'japsu';
    'japsu@myrmidon-20140906':
      ensure => present,
      key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC8KapX1r3pc0u69AGgC2oQXdHJ7mXOnUcWIIyo1wOyxXtUWs53fkW1HgD5PcBt567S8zoPoWEB9LMG+JCFpJty3W7TVn1T+vCexI1mBr6tgi+uzNPAJSYQLYF2y5IGiTfV/db1NX37QX8S6ujcO08/082oJmUMgolCYxcZjzVBdzkUOf/mjZYxLJhVY1r7xK4ORUcxktoA/iMD6ybZl6HG8awNnPpZ+bqzWBBX8jcBIYq9qPA1JbZ6b0gClqAWqkpf0KXR06De1QgAANiMCRKDKoD/6jE+7uqOEISI3l97QIwzZ9OZjOdunevs0PBUEpjQNMqIDmuuKMqb6tHvp/2F',
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
