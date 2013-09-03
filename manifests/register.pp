class rsyslog::registration(
        $server_name = 'default',
        $use_tcp = true,
        $use_udp = false
) {
        if ! defined(Class['rsyslog']) {
                fail('You must include the rsyslog base class before using any rsyslog defined resources')
        }

        if $use_tcp {
                @@concat::fragment{ 'rsyslog_register_tcp_${::fqdn}_${server_name}':
                        target  => '/etc/rsyslog.d/allowed_hosts.conf',
                        content => template("rsyslog/register_tcp.conf"),
                        tag     => 'rsyslog_register_tcp_${server_name}',
                }
        }

        if $use_udp {
                @@concat::fragment{ 'rsyslog_register_udp_${::fqdn}_${server_name}':
                        target  => '/etc/rsyslog.d/allowed_hosts.conf',
                        content => template("rsyslog/register_udp.conf"),
                        tag     => 'rsyslog_register_udp_${server_name}',
                }
        }
}
