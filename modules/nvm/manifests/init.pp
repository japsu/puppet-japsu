class nvm {
  define user_nvm(
    $user=$title,
    $autoload=false
  ) {
    # TODO support non-/home users (eg. /srv)
    $nvm_path="/home/$user/.nvm"

    vcsrepo {
      $nvm_path:
        ensure => present,
        provider => git,
        source => 'https://github.com/creationix/nvm',
        user => $user;
    }

    if ($autoload) {
      exec {
        "load nvm from .bashrc for $user":
          unless => "/bin/fgrep -q nvm.sh /home/$user/.bashrc",
          command => "echo '\nsource ~/.nvm/nvm.sh' >> /home/$user/.bashrc",
          provider => shell;
      }
    }
  }

  define user_node($set_as_default=false) {
    $split_title = split($title, '/')
    $user = $split_title[0]
    $version = $split_title[1]

    # XXX query this from the resource?
    $nvm_path = "/home/$user/.nvm"

    exec {
      "install node $version for $user":
        require => User_nvm[$user],
        creates => "$nvm_path/$version",
        command => "/bin/su - $user -c '. $nvm_path/nvm.sh && nvm install $version'";
    }

    if ($set_as_default) {
      exec {
        "set node $version as default for $user":
          require => User_nvm[$user],
          unless => "/bin/grep -q $version $nvm_path/alias/default",
          command => "/bin/su - $user -c '. $nvm_path/nvm.sh && nvm alias default $version'";
      }
    }
  }
}