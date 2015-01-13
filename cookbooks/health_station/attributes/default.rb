default[:health_station][:config_file]				= 'HealthStation.exe.config'
default[:health_station][:config_path]				= ::File.join(::Dir.tmpdir(),node[:health_station][:config_file])

default[:health_station][:config]['Branding']		= nil
default[:health_station][:config]['Group']			= nil
default[:health_station][:config]['EmailLogFile']	= nil
default[:health_station][:config]['StationName']	= nil

