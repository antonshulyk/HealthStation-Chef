require 'rexml/document'

def whyrun_supported?
  true
end

use_inline_resources

action :update do
  did_update = false

  if config_file_exist?(new_resource.path)
    content = REXML::Document.new read_config_file(new_resource.path)
    new_resource.config_items.each do |key, value|
    
      # if new value is nil - skip
      if value.nil?
        Chef::Log.info "Setting #{key} value is nil - skipping"
        next
      end

      setting = content.elements["*/*/*/setting[@name='#{key}']"]
      # if setting doesn't exist - skip
      if setting.nil?()
         Chef::Log.info "Setting #{key} not found - skipping"
         next      
      end

      # get the current value
      current_value_element = setting.elements["value"]
      current_value = current_value_element.has_text? ? current_value_element.get_text.value : nil
      
      # if setting value the same - skip
      if current_value.eql?(value)
        Chef::Log.info "Setting #{key} found, current value: #{current_value}, new value: #{value} - skipping"
        next
      end

      Chef::Log.info "Setting #{key} found, current value: #{current_value}, new value: #{value} - updating"
      current_value_element.text = value
      did_update = true
    end

    if did_update
      Chef::Log.info "Config file #{new_resource.path} will be updated"
      converge_by("#{new_resource.path} file updated") do
        update_config_file new_resource.path, content
      end
      new_resource.updated_by_last_action(true)
    end
  end
end

def update_config_file path, content
  ::File.open(path, 'w') do |f|
    f.write content
  end
end

def read_config_file path
  IO.read(path)
end

def config_file_exist?(path)
  if ::File.exists?(path)
    true
  else
    Chef::Log.info "Config file #{path} dose not exist!"
    false
  end
end