class japsu::sudo::nopasswd {
  include sudo

  sudo::conf {
    'japsu_nopasswd':
      content => "japsu ALL=(ALL) NOPASSWD: ALL\n"
  }
}