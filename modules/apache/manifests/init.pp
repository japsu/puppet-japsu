class apache {
  define site ($app_root) {
    file {
      "/etc/apache2/sites-available/$title":
        require => Package['apache2'],
        notify => Service['apache2'],
        ensure => present,
        content => template('apache/vhost.conf.erb');
    }

    exec {
      "a2ensite $title":
        command => "/usr/sbin/a2ensite $title",
        creates => "/etc/apache2/sites-enabled/$title",
        notify => Service['apache2'];
    }
  }

  file {
    '/var/www/index.html':
      ensure => present,
      content => template('apache/index.html.erb');
  }

  package {
    'apache2':
      ensure => present;
  }

  service {
    'apache2':
      ensure => running,
      enable => true,
      hasrestart => true,
      hasstatus => true;
  }
}