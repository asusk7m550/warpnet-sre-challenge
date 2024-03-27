# == Class: profiles::nginx
#
# === Documentation
#
# https://github.com/voxpupuli/puppet-nginx/blob/master/REFERENCE.md
#
# @param confd_purge
#   purge existing configuration from nginx conf.d directory
class profiles::nginx (
  Boolean $confd_purge = true,
) {
  class { 'nginx':
    confd_purge           => $confd_purge,
    client_body_temp_path => '/var/tmp/nginx_client_body_temp',
    proxy_temp_path       => '/var/tmp/nginx_proxy_temp',
    ssl_protocols         => 'TLSv1.2 TLSv1.3',
    ssl_ciphers           => 'HIGH:MEDIUM:!aNULL:!MD5:!RC4:!3DES',
    ssl_stapling          => 'on',
    http2                 => 'on',
    server_tokens         => 'off',
  }
}
