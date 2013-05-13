class japsu::basics {
  package {
    [
      'bind9-host',
      'bsdmainutils',
      'ca-certificates',
      'git',
      'git-core',
      'htop',
      'less',
      'man-db',
      'manpages-dev',
      'patch',
      'pwgen',
      'rsync',
      'screen',
      'tig',
      'vim',
      'subversion',
    ]:
      ensure => present;
  }

  file {
    # console font
    '/etc/default/console-setup':
      ensure => present,
      owner => 'root',
      group => 'root',
      mode => 0644,
      source => 'puppet:///modules/japsu/console-setup';
  }

  exec {
    # EDITOR=vim
    'update_alternatives_set_editor_vim':
      command => 'update-alternatives --set editor /usr/bin/vim.basic',
      unless => 'ls -la /etc/alternatives/editor | grep -q vim',
      provider => 'shell';
  }
}