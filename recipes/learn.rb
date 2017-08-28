#resource name = apache 
package 'apache' do
    # package name = httpd
    #yum will look for package name
    package_name 'httpd'
end

# service resource type
service 'httpd' do
   action [:enable,:start]
end

file '/var/www/index.html' do
   action :delete
end

file '/var/www/html/index.html' do
   content 'Hello World'
   mode '0755' 
   owner 'root'
   group 'apache'
end

execute 'command-test' do
   command 'echo blah >> /etc/motd'
   #not_if 'test -r /etc/motd'
   only_if { ::File.exists?('/etc/motd')} 
end 

file '/etc/motd' do 
   content 'Welcome to my server' 
end


