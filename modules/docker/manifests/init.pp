class docker {
  include apt

  apt::source {
    'docker':
      location => 'http://get.docker.io/ubuntu',
      release => 'docker',
      repos => 'main',
      key_source => 'https://get.docker.io/gpg',
      include_src => false;
  }

  package {
    'lxc-docker':
      ensure => present;
  }

  file {
    '/cgroup':
      ensure => directory;
  }

  fstab {
    'cgroups for lxc':
      source => 'none',
      dest   => '/cgroup',
      type   => 'cgroup',
      opts   => 'defaults',
      dump   => 0,
      passno => 0;
  }
}
