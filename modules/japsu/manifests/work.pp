class japsu::work {
  include japsu::apt
  include japsu::basics
  include japsu::env
  include japsu::samba::work
  include japsu::user
  include japsu::ssh::keys::work
  include japsu::rvm
}