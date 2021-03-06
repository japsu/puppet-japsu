class edegal {
  include edegal::deps

  define instance(
    $project_root='/srv/edegal',
    $listen='127.0.0.1:9000',
    $source='https://github.com/japsu/edegal',
    $revision='master',
    $user='edegal',
    $node_version='v0.10.32'
  ) {
    $nvm_path = "$project_root/.nvm"
    $nvm = "$nvm_path/nvm.sh"
    $nvm_init = "source $nvm"
    $app_root = "$project_root/app"
    $su_invocation = "/bin/su $user -l -c"

    group {
      $user:
        ensure => present;
    }

    user {
      $user:
        ensure => present,
        gid => $user,
        home => $project_root,
        shell => '/bin/bash',
        managehome => true;
    }
    
    vcsrepo {
      $app_root:
        require => User[$user],
        ensure => latest,
        provider => git,
        source => $source,
        revision => $revision,
        user => $user;
    }

    nvm::user_nvm {
      $user:
        autoload => true,
        bashrc => "$project_root/.bashrc",
        nvm_path => $nvm_path;
    }

    nvm::user_node {
      "$user/$node_version":
        set_as_default => true,
        nvm_path => $nvm_path;
    }

    exec {
      "npm install forever for edegal $title":
        require => [ Vcsrepo[$app_root], Nvm::User_node["$user/$node_version"] ],
        creates => "$app_root/node_modules/.bin/forever",
        command => "$su_invocation '$nvm_init && cd $app_root && npm install forever'";

      "npm install for edegal $title":
        subscribe => [ Vcsrepo[$app_root], Nvm::User_node["$user/$node_version"] ],
        refreshonly => true,
        command => "$su_invocation '$nvm_init && cd $app_root && npm install'";

      # "start edegal $title":
      #   subscribe => [ Vcsrepo[$app_root], Exec["npm install for edegal $title"] ],
      #   require => Exec["npm install forever for edegal $title"],
      #   command => "$su_invocation '$nvm_init && cd $app_root && node_modules/.bin/forever start -c node_modules/.bin/coffee server/server.coffee'";

      # "restart edegal $title":
      #   subscribe => [ Vcsrepo[$app_root], Exec["npm install for edegal $title"] ],
      #   require => Exec["npm install forever for edegal $title"],
      #   command => "$su_invocation '$nvm_init && cd $app_root && node_modules/.bin/forever restart -c node_modules/.bin/coffee server/server.coffee'";
    }

    cron {
      'start edegal $title on reboot':
        special => 'reboot',
        command => "$nvm_init && nvm use $node_version && cd $app_root && forever start -l log/forever.log -o log/out.log -e log/error.log -c node_modules/.bin/coffee_script server/server.coffee";
    }
  }
}
