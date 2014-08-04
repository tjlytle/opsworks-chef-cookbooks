node[:deploy].each do |application, deploy|
  
  template "#{deploy[:deploy_to]}/current/#{node[:local_config][application.to_s][:path]}/#{node[:local_config][application.to_s][:file]}" do
    source "local_config.php.erb"
    owner deploy[:user] 
    group deploy[:group]
    mode "0666"

    variables( 
        :config => (node[:local_config] rescue nil), 
        :application => "#{application}" 
    )

    only_if do
     File.directory?("#{deploy[:deploy_to]}/current/#{node[:local_config][application.to_s][:path]}")
    end
  end
end
