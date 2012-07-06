class rsyslog (
	$remote_logging = true,
	$protocol = 'tcp',
	$server = '127.0.0.1',
	$server_port = 514,
	$enable_tcp                = true,
	$enable_udp                = true,
	$high_precision_timestamps = false
) {
	$is_rsyslog_server = $is_rsyslog_server ? {
		'' => "false",
		default => $is_rsyslog_server
	}
	
	service { "rsyslog":
		ensure  => running,
		enable  => true,
	}
	
	package { "rsyslog":
		ensure => "installed",
	}
	
	
	if $is_rsyslog_server {
		file { "/etc/rsyslog.conf":
			ensure  => present,
			owner   => root,
			group   => root,
			mode    => 0644,
			content => template("rsyslog/server.conf.erb"),
			notify  => Service["rsyslog"],
		}
	}
	else {
		file { "/etc/rsyslog.conf":
			ensure  => present,
			owner   => root,
			group   => root,
			mode    => 0644,
			content => template("rsyslog/client.conf.erb"),
			notify  => Service["rsyslog"],
		}
	}
}
