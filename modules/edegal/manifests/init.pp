class edegal(
  $project_root='/srv/edegal'
  $listen='127.0.0.1:9000',
  $source='https://github.com/japsu/edegal-express',
  $revision='master',
  $user='edegal',
  $node_version='v0.10.12'
) {
  $nvm_path = "$project_root/nvm"
  $app_root = "$project_root/app"

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
    $nvm_path:
      require => User[$user],
      ensure => present,
      provider => git,
      source => "http://github.com/creationix/nvm",
      revision => $revision,
      user => $user;

    $app_root:
      require => User[$user],
      ensure => present,
      provider => git,
      source => $source,
      revision => $revision,
      user => $user;
  }

  exec {
    'edegal_nvm_install_node':
      require => Vcsrepo[$nvm_path]
      creates => "$nvm_path/$node_version",
      command => "source $project_root/nvm/nvm.sh && nvm install $node_version && nvm default $node_version",
      provider => shell;

    'edegal_npm_install':
      require => Vcsrepo[$nvm_path], 
      subscribe => [ Vcsrepo[$app_root], Exec['edegal_nvm_install_node'] ],
      refreshonly => true,
      command => "source $project_root/nvm/nvm.sh && nvm use $node_version && cd $app_root && npm install";

    'edegal_npm_install_forever':
      require => Exec['edegal_nvm_install_node'],
      creates => "$nvm_path/$node_version/bin/forever",
      command => "source $project_root/nvm/nvm.sh && nvm use $node_version && npm -g install forever";

    'restart_edegal':
      subscribe => [ Vcsrepo[$app_root], Exec['edegal_npm_install'] ],
      command => "source $project_root/nvm/nvm.sh && nvm use $node_version && cd $app_root && forever restart -l log/forever.log -o log/out.log -e log/error.log -c node_modules/.bin/coffee_script server/server.coffee",
      provider => shell;
  }

  cron {
    'start_edegal_on_reboot':
      special => 'reboot',
      command => "source $project_root/nvm/nvm.sh && nvm use $node_version && cd $app_root && forever start -l log/forever.log -o log/out.log -e log/error.log -c node_modules/.bin/coffee_script server/server.coffee";
  }
}