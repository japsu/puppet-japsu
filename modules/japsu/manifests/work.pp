class japsu::work {
  include japsu::apt
  include japsu::basics
  include japsu::env
  include japsu::samba::work
  include japsu::user
  include japsu::sudo::nopasswd
  include japsu::ssh::keys::work
  include japsu::ruby
  include japsu::ruby::capistrano
  include japsu::ruby::capybara
  include japsu::ruby::rmagick
  include japsu::nvm
  include japsu::ssh
  include japsu::vim

  include nginx
  include php::fpm

  # TODO these are specific to certain projects and probably not needed on every installation
  include mongodb
  include redis
  include mysql

  package {
    [
      'ffmpeg',
      'vorbis-tools',
      'lame'
    ]:
      ensure => present;
  }

  class {
    'japsu::git':
      email_address => 'santtu.pajukanta@leonidasoy.fi';
  }

  if $virtual == 'virtualbox' {
    include virtualbox::guest
  }
}