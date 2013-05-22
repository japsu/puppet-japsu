class japsu::vim {
  package {
    'vim':
      ensure => present;
  }

  file {
    '/home/japsu/.vimrc':
      require => User['japsu'],
      ensure => present,
      source => 'puppet:///modules/japsu/vimrc',
      owner => 'japsu',
      group => 'japsu';
  }

  exec {
    # EDITOR=vim
    'update_alternatives_set_editor_vim':
      require => Package['vim'],
      command => 'update-alternatives --set editor /usr/bin/vim.basic',
      unless => 'ls -la /etc/alternatives/editor | grep -q vim',
      provider => 'shell';
  }
}