health_station

calling this recipe should update the settings file using each of the attributes
in the hash node[:health_station][:config]

:config attributes might be specified in an environment and/or role that a node belongs to.

sample usage:

health_station_app_settings node[:health_station][:config_path] do
   config_items node[:health_station][:config]
   notifies :run, "execute[echo hello world]", :immediately
end

business rules:
1) IF 
		the existing config file has a setting x with a value of y
  AND 
      the node has a :config attribute x with a value of z 
  THEN
    the config file setting for x should have it's value changed to z
  AND
    the resource should be flagges as having been modified

 example
	config file:
           <setting name="StationName" serializeAs="String">
               <value>SISUStation00</value>
           </setting>

 node[:health_station][:config][:StationName] = 'MyStation'

result 
  config file modified and resource marked as modified:
           <setting name="MyStation" serializeAs="String">
               <value>SISUStation00</value>
           </setting>

2) IF 
		the existing config file has a setting x with a value of y
  AND 
      the node has a :config attribute x with a value of nill 
  THEN
     don't attempt to modify the existing config file

 example
	config file:
           <setting name="StationName" serializeAs="String">
               <value>SISUStation00</value>
           </setting>

 node[:health_station][:config][:StationName] = nil

result
 config file is NOT modified

3) IF 
		the existing config file has a setting x with a value of y
  AND 
      the node has a :config attribute x with a value of y 
  THEN
     don't attempt to modify the existing config file

 example
	config file:
           <setting name="StationName" serializeAs="String">
               <value>SISUStation00</value>
           </setting>

 node[:health_station][:config][:StationName] = SISUStation00

result
 config file is NOT modified
