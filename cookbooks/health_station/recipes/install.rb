cookbook_file "HealthStation.exe.config" do
	path node[:health_station][:config_path]
	action :create
end