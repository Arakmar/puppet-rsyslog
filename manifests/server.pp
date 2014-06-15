class rsyslog::server (
        $listen_tcp = false,
        $listen_tcp_port = 514,
        $listen_udp = false,
        $listen_udp_port = 514,
        $high_precision_timestamps = false,
        $server_name = 'default'
) {
        class {
                'rsyslog':
                        listen_tcp => $listen_tcp,
                        listen_tcp_port => $listen_tcp_port,
                        listen_udp => $listen_udp,
                        listen_udp_port => $listen_udp_port,
                        high_precision_timestamps => $high_precision_timestamps
        }

        if listen_tcp {
                Concat::Fragment <<| tag == "rsyslog_register_tcp_${server_name}" |>> {
                        target => "/etc/rsyslog.d/allowed_hosts.conf"
                }
        }

        if listen_udp {
                Concat::Fragment <<| tag == "rsyslog_register_udp_${server_name}" |>> {
                        target => "/etc/rsyslog.d/allowed_hosts.conf"
                }
        }

        concat::fragment {"rsync_register_header":
                target => "/etc/rsyslog.d/allowed_hosts.conf",
                content => template("rsyslog/register_header.conf"),
                order => 05,
        }

        concat{ "/etc/rsyslog.d/allowed_hosts.conf":
                owner => root, 
                group => root, 
                mode => 0644,
                notify => Service["rsyslog"],
                require => Package["rsyslog"]
        }
}
