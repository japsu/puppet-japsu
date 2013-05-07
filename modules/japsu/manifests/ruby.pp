class japsu::ruby {
  package {
    [
      'libgdbm-dev',
      'libncurses5-dev',
      'automake',
      'libtool',
      'pkg-config',
      'libffi-dev',
    ]:
      ensure => present;
  }

  include rvm

  rvm::system_user {
    'japsu': ;
  }

  if $rvm_installed == 'true' {
    rvm_system_ruby {
      'ruby-1.9.3-p392':
        ensure => 'present',
        default_use => true;
    }
  }
}

class japsu::ruby::capybara {
  package {
    [
      'libqt4-dev',
      'libqtwebkit-dev',
      'xvfb'
    ]:
      ensure => present;
  }
}