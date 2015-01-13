actions :update
default_action :update

state_attrs :config_items

attribute :path, :kind_of => String, :name_attribute => true
attribute :config_items, :kind_of => Hash