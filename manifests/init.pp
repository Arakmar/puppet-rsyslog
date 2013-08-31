class rsyslog (
        $remote_logging = false,
        $local_logging = true,
	$protocol = 'tcp',
	$server = '127.0.0.1',
	$server_port = 514,
        $listen_tcp = false,
        $listen_tcp_port = 514,
        $listen_udp = false,
        $listen_udp_port = 514,
	$high_precision_timestamps = false,
) {
	service { "rsyslog":
		ensure  => running,
		enable  => true,
	}
	
	package { "rsyslog":
		ensure => "installed",
	}
	
	file { "/etc/rsyslog.d":
                ensure  => directory,
                owner   => root,
                group   => root,
                mode    => 0755,
                purge => true,
                force => true,
                recurse => true,
                notify  => Service["rsyslog"],
                require => Package["rsyslog"]
        }
	
	file { "/etc/rsyslog.conf":
                ensure  => present,
                owner   => root,
                group   => root,
                mode    => 0644,
                content => template("rsyslog/rsyslog.conf.erb"),
                notify  => Service["rsyslog"],
        }
}
