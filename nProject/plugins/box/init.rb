#require 'redmine'
#require 'box/box'
Redmine::Plugin.register :box do
  name 'Box plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'


 # requires_redmine :version_or_higher => '2.0.0'  
  
  #settings :default => {
   # :uncompleted_todo_status   => nil,
    #:completed_todo_status => nil
  #}, :partial => 'settings/box'

#  project_module :box_module do
 #    permission "view", {
  #       :box  => :index
   #  }

  #end

 # menu :project_menu, :box, {:controller => 'boxelements', :action => 'index'}, :caption => 'box', :param => :project_id, :after => :activity

end
