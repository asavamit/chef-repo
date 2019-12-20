#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package 'nginx' do
  action :install
end

cookbook_file '/usr/share/nginx/html/index.html' do
  source 'index.txt'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/usr/share/nginx/html/.htacess' do
  source 'htaccess.txt'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

directory '/usr/share/nginx/security' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

bash 'create htpasswd' do
cwd '/usr/share/nginx/security'
  code <<-EOH
    htpasswd -cb .htpasswd admin pass1234
  EOH
  action :run
  not_if { File.exists?('/usr/share/nginx/security/.htpasswd')}

end

service 'nginx' do
  action [:enable, :restart]
end
