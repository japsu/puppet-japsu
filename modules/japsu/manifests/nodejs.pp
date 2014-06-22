class japsu::nodejs {
  include ::nvm

  nvm::user_nvm {
    'japsu':
      autoload => true;
  }

  nvm::user_node {
    'japsu/v0.10.29':
      set_as_default => true;
  }
}
