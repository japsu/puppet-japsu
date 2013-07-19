class edegal(
  $project_root='/srv/edegal'
  $listen='127.0.0.1:9000',
  $source='https://github.com/japsu/edegal-express',
  $revision='master',
  $user='edegal',
  $node_version='v0.10.12'
) {
  $nvm_path = "$project_root/.nvm"
  $nvm = "$nvm_path/nvm.sh"
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
      managehome => true;
  }
  
  vcsrepo {
    $app_root:
      require => User[$user],
      ensure => present,
      provider => git,
      source => $source,
      revision => $revision,
      user => $user;
  }

  nvm::user_nvm {
    $user:
      autoload => true;
  }

  nvm::user_node {
    "$user/v0.10.13":
      set_as_default => true;
  }

  exec {
    'edegal_npm_install':
      subscribe => Vcsrepo[$app_root],
      refreshonly => true,
      command => "$su_invocation 'cd $app_root && npm install'";

    'restart_edegal':
      subscribe => [ Vcsrepo[$app_root], Exec['edegal_npm_install'] ],
      command => "$su_invocation 'cd $app_root && forever restart -l log/forever.log -o log/out.log -e log/error.log -c node_modules/.bin/coffee_script server/server.coffee'";
  }

  cron {
    'start_edegal_on_reboot':
      special => 'reboot',
      command => "source $nvm && nvm use $node_version && cd $app_root && forever start -l log/forever.log -o log/out.log -e log/error.log -c node_modules/.bin/coffee_script server/server.coffee";
  }
}