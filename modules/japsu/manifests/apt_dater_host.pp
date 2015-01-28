class japsu::apt_dater_host {
  package {
    'apt-dater-host':
      ensure => present;
  }

  group {
    'slave':
      ensure => present;
  }

  user {
    'slave':
      gid => 'slave',
      shell => '/bin/bash',
      system => true;
  }

  file {
    '/home/slave/.ssh':
      ensure => directory,
      owner => 'slave',
      group => 'slave';
    '/etc/sudoers.d/10_aptdater_slave':
      ensure => present,
      content => "slave ALL=(ALL) NOPASSWD: /usr/bin/apt-get\n"
  }

  ssh_authorized_key {
    'japsu@myrmidon-20140906-apt-dater':
      ensure => present,
      key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC8KapX1r3pc0u69AGgC2oQXdHJ7mXOnUcWIIyo1wOyxXtUWs53fkW1HgD5PcBt567S8zoPoWEB9LMG+JCFpJty3W7TVn1T+vCexI1mBr6tgi+uzNPAJSYQLYF2y5IGiTfV/db1NX37QX8S6ujcO08/082oJmUMgolCYxcZjzVBdzkUOf/mjZYxLJhVY1r7xK4ORUcxktoA/iMD6ybZl6HG8awNnPpZ+bqzWBBX8jcBIYq9qPA1JbZ6b0gClqAWqkpf0KXR06De1QgAANiMCRKDKoD/6jE+7uqOEISI3l97QIwzZ9OZjOdunevs0PBUEpjQNMqIDmuuKMqb6tHvp/2F',
      type => 'ssh-rsa',
      user => 'slave';
  }
}
