class nvm {
  define user_nvm(
    $user=$title,
    $nvm_path="/home/$title/.nvm",
    $autoload=false,
    $bashrc="/home/$user/.bashrc" # XXX
  ) {
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
          unless => "/bin/fgrep -q nvm.sh $bashrc",
          command => "echo '\nsource $nvm_path/nvm.sh' >> $bashrc",
          provider => shell;
      }
    }
  }

  define user_node(
    $set_as_default=false,
    $nvm_path=undef
  ) {
    $split_title = split($title, '/')
    $user = $split_title[0]
    $version = $split_title[1]

    if $nvm_path {
      $actual_nvm_path = $nvm_path
    } else {
      $actual_nvm_path = "/home/$user/.nvm"
    }

    exec {
      "install node $version for $user":
        require => User_nvm[$user],
        creates => "$actual_nvm_path/$version",
        command => "/bin/su - $user -c '. $actual_nvm_path/nvm.sh && nvm install $version'";
    }

    if ($set_as_default) {
      exec {
        "set node $version as default for $user":
          require => User_nvm[$user],
          unless => "/bin/grep -q $version $actual_nvm_path/alias/default",
          command => "/bin/su - $user -c '. $actual_nvm_path/nvm.sh && nvm alias default $version'";
      }
    }
  }
}