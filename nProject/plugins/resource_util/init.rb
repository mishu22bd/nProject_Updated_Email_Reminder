Redmine::Plugin.register :resource_util do
  name 'Resource Util plugin'
  author 'Sayem Chowdhury'
  description 'This is a plugin to show Resource Ulitization Summary'
  version '0.0.1'
  url ''
  author_url ''
end


#Redmine::Plugin.register :redmine_polls do

  #menu :application_menu, :polls, { :controller => 'resource_util', :action => 'index' }, :caption => 'Resource Utilization'
#end


Redmine::Plugin.register :redmine_resource_util do
  
  permission :resource_util, { :resource_util => [:index] }, :public => true
  menu :project_menu, :resource_util, { :controller => 'resource_util', :action => 'index' }, :caption => 'Resource Utilization Summary', :after => :activity, :param => :project_id
end

