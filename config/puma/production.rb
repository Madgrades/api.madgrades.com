bind 'unix:///var/run/madgrades_api.sock'
pidfile '/var/run/madgrades_api.pid'
Process.daemon(true)
