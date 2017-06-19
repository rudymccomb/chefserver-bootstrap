file '/hello.txt' do
  content 'Hello World'
end


chef_ingredient "chef-server" do
  config <<-EOS
api_fqdn "#{node["fqdn"]}"
ip_version "ipv6"
notification_email "#{node["chef_admin"]}"
nginx["ssl_protocols"] = "TLSv1 TLSv1.1 TLSv1.2"
EOS
  action :install
end

ingredient_config "chef-server" do
  notifies :reconfigure, "chef_ingredient[chef-server]"
end


chef_ingredient 'analytics' do
  channel :current
  action :install
end
