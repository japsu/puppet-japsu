class japsu::tracontent {
    define instance(
        $user,
        $listen,
        $repository='/srv/git/tracontent.git',
        $branch='staging',
    ) {
        japsu::django::instance {
            $title:
                user => $user,
                wsgi_app => 'tracontent.wsgi:application',
                listen => $listen,
                source => $repository,
                revision => $branch;
        }

        file {
            "/srv/$title/app/media":
                ensure => 'directory',
                owner => $user,
                group => $user,
                mode => 0755; # dr-xrwsrwx user-writable uploads folder

            [
                "/srv/$title/app/media/uploads",
                "/srv/$title/app/media/banners",
            ]:
                ensure => 'directory',
                owner => $user,
                group => $user,
                mode => 02775; # dr-xrwsrwx user-writable uploads folder
        }
    }

    define site(
        $instance,
        $template='nginx/proxy.conf.erb',
        $letsencrypt=false,
        $ssl=true,
        $ssl_certificate=undef,
        $ssl_certificate_key=undef,
    ) {
        $listen = getparam(Japsu::Tracontent::Instance[$instance], 'listen')

        nginx::proxy {
            $title:
                target => "http://$listen",
                static_path => "/srv/$instance/app/static",
                media_path => "/srv/$instance/app/media",
                template => $template,
                letsencrypt => $letsencrypt,
                ssl => $ssl,
                ssl_certificate => $ssl_certificate,
                ssl_certificate_key => $ssl_certificate_key;
        }
    }
}
