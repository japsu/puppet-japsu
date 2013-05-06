class japsu::rvm {
  include rvm

  rvm::system_user {
    'japsu': ;
  }

  rvm_system_ruby {
    'ruby-1.9.2-p392':
      ensure => 'present',
      default_use => true;
  }
}