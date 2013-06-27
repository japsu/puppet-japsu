class nvm {
  define user_nvm(
    $user=$title,
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
  }

  define user_node() {
    $split_title = split($title, '/')
    $user = $split_title[0]
    $version = $split_title[1]

    # XXX query this from the resource?
    $nvm_path = "/home/$user/.nvm"

    exec {
      "install node ${version} for ${user}":
        require => User_nvm[$user],
        creates => "$nvm_path/$version",
        command => "su - $user -c '. $nvm_path/nvm.sh && nvm install $version'",
        provider => shell;
    }
  }
}