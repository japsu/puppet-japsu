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

    rvm_gem {
      'ruby-1.9.3-p392/bundler':
        ensure => '1.3.5',
        require => Rvm_system_ruby['ruby-1.9.3-p392'];
    }
  }
}

class japsu::ruby::capistrano {
  if $rvm_installed == 'true' {
    rvm_gem {
      'ruby-1.9.3-p392/capistrano':
        ensure => '2.15.4',
        require => Rvm_system_ruby['ruby-1.9.3-p392'];
      'ruby-1.9.3-p392/rvm-capistrano':
        ensure => '1.3.0',
        require => Rvm_system_ruby['ruby-1.9.3-p392'];
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