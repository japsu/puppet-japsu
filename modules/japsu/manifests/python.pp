class japsu::python {
  package {
    [
      'python',
      'python-virtualenv'
    ]:
      ensure => present;
  }
}