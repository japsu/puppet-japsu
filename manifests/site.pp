File {
  owner => 'root',
  group => 'root',
  mode  => 0644
}

node valkyrie {
  class {
    'japsu::network::work':
      ip_address => '192.168.56.5';
  }

  include japsu::work

}

node hornet {
  include japsu::personal
  include japsu::sudo::nopasswd
}

node helios {
  include japsu::personal
  include japsu::samba

  include nginx
  include japsu::torrent
}

node enyo {
  include japsu::personal
  include japsu::samba
}

node lachesis {
  include japsu::personal
  include japsu::irc
  include japsu::fstab

  include mongodb
  include postgresql
  include nginx
  include edegal
  include green_unicorn

  edegal::instance {
    'kuvat.japsu.fi':
      project_root => '/srv/kuvat.japsu.fi',
      listen => '127.0.0.1:9000',
      user => 'kuvatjapsufi',
      source => '/srv/git/edegal-express.git',
      revision => 'production';
  }

  japsu::django::instance {
    'forms.japsu.fi':
      listen => '127.0.0.1:9001',
      user => 'forms',
      source => '/srv/git/forms-japsu-fi.git',
      revision => 'production',
      ssl => false,
      wsgi_app => 'forms_japsu_fi.wsgi:application';
  }

  japsu::tracontent::instance {
    'tracontent.japsu.fi':
      user => 'tracontent',
      listen => '127.0.0.1:9002',
      branch => 'japsufi';
  }

  japsu::tracontent::site {
    'japsu.fi':
      instance => 'tracontent.japsu.fi',
      letsencrypt => true,
      ssl => true,
      ssl_certificate => '/srv/letsencrypt/secrets/japsu.fi/chained.pem',
      ssl_certificate_key => '/srv/letsencrypt/secrets/japsu.fi/domain.key';
  }

  nginx::site {
    'kuvat.japsu.fi':;
  }

  nginx::redirect {
    'kalenteri.japsu.fi':
      target => 'http://www.google.com/calendar/embed?src=santtu%40pajukanta.fi&ctz=Europe/Helsinki';
    'www.japsu.fi':
      target => 'https://japsu.fi';
  }

  ssh_authorized_key {
    'japsu+kuvatjapsufi@navitas-20130719':
      ensure => present,
      key => 'AAAAB3NzaC1yc2EAAAABJQAAAQBm2r27t6Z/M5vfiXhjlGBkv94QilQRlwexlipgt+q1CfaKKlBJAS85X5/OJj4ATT9ijh+9Y+p4AYjO3OnwvSKLD6UjQwchEe28RJ1X3o85wJ12TpHXhWWl2rCF0uXrYTJom1fcUyC9eqy55l7M6UT3p7jeYKeFnhyRw4JnN3jAMX839504k/u304Rz7Hwl0aSJ6y9mOdvYzqS52OR0YQBJI4c8CPkdaywAYlCWSzB//M2JSBtm/QKwfKZwmqq8JNc19+Wyzr2sRWG876njbQia2WWlQ42/NbVmsCcuuPuVH3kwcdaIgnQDaqpIqLhs9ydSYYo7Fg83oF9PzHwsM6ct',
      type => 'ssh-rsa',
      user => 'kuvatjapsufi';
  }
}
