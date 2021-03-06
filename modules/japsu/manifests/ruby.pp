class japsu::ruby {
  $ruby_version = 'ruby-2.1.1'

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
      "$ruby_version":
        ensure => 'present',
        default_use => true;
    }

    rvm_gem {
      "$ruby_version/bundler":
        ensure => latest,
        require => Rvm_system_ruby["$ruby_version"];

      "$ruby_version/zeus":
        ensure => latest,
        require => Rvm_system_ruby["$ruby_version"];

      "$ruby_version/chef":
        ensure => latest,
        require => Rvm_system_ruby["$ruby_version"];

      "$ruby_version/berkshelf":
        ensure => latest,
        require => Rvm_system_ruby["$ruby_version"];
    }
  }

  file {
    '/home/japsu/.gemrc':
      ensure => present,
      owner => 'japsu',
      group => 'japsu',
      mode => 0644,
      source => 'puppet:///modules/japsu/gemrc';
  }
}

class japsu::ruby::capistrano {
  if $rvm_installed == 'true' {
    rvm_gem {
      "$japsu::ruby::ruby_version/capistrano":
        ensure => latest,
        require => Rvm_system_ruby["$japsu::ruby::ruby_version"];
      "$japsu::ruby::ruby_version/rvm-capistrano":
        ensure => latest,
        require => Rvm_system_ruby["$japsu::ruby::ruby_version"];
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

class japsu::ruby::rmagick {
  package {
    [
      'imagemagick',
      'libmagickwand-dev'
    ]:
      ensure => present;
  }
}
