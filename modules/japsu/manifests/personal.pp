class japsu::personal {
  include japsu::apt
  include japsu::basics
  include japsu::env
  include japsu::git
  include japsu::ssh
  include japsu::ssh::keys::personal
  include japsu::user
  include japsu::vim
}