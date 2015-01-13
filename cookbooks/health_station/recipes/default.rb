#
# Cookbook Name:: health_station
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

app_settings node[:health_station][:config_path] do
   config_items node[:health_station][:config]
   notifies :run, "execute[echo hello world]", :immediately
end

execute "echo hello world" do
  action :nothing
end
