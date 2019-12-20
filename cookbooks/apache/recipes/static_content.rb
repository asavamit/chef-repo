#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package 'httpd' do
   action :install
end

cookbook_file '/var/www/html/index.html' do
   source 'index.txt'
   owner 'root'
   group 'root'
   mode '0755'
   action :create
end

service 'httpd' do
   action [:enable, :start]
end
