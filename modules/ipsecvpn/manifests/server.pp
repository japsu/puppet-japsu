class ipsecvpn::server {
  package {
    [
      "xl2tpd",
      "openswan",
      "ppp",
    ]:
      ensure => present;
  }

  file {
    '/etc/ipsec.conf':
      ensure => present,
      source => 'puppet:///ipsecvpn/ipsec.conf';
    '/etc/init.d/ipsec.vpn':
      ensure => present,
      mode => 0755,
      source => 'puppet:///ipsecvpn/ipsec.vpn.sysvinit';
    '/etc/x2ltpd/x2ltpd.conf':
      ensure => present,
      source => 'puppet:///ipsecvpn/x2ltpd.conf';
    '/etc/ppp/options.x2ltpd':
      ensure => present,
      source => 'puppet:///ipsecvpn/options.x2ltpd.ppp';
  }

  service {
    'ipsec':
      enabled => false,
      hasstatus => true,
      hasrestart => true;
    'ipsec.vpn':
      ensure => started,
      enabled => true,
      hasstatus => false,
      hasrestart => true;
  }

  # NOTE: You need to setup secrets files manually:
  # - /etc/ipsec.secrets
  # - /etc/xl2tpd/l2tp-secrets
  # - /etc/ppp/chap-secrets
}
