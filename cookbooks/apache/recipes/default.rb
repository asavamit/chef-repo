#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package 'httpd' do
   action :install
end

template '/var/www/html/index.html' do
   source 'index.erb'
   owner 'root'
   group 'root'
   mode '0755'
   variables(
     :os => node['os'],
     :ip1 => node['ipaddress'],
     :ip2 => node['ec2']['public_ipv4']
   )
   action :create
end

service 'httpd' do
   action [:enable, :start]
end
