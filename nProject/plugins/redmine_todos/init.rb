# encoding: utf-8

require 'redmine'
require 'redmine_todos/redmine_todos'

Redmine::Plugin.register :redmine_todos do
  name 'Tasklist'
  author 'nksoft'
  description 'tasklist for iMeet'
  version '0.0.1'
  url 'http://imeet.biz'

  requires_redmine :version_or_higher => '2.0.0'  
  
  settings :default => {
    :uncompleted_todo_status   => nil,
    :completed_todo_status => nil
  }, :partial => 'settings/todos'

  project_module :todos_module do
     permission :view_todo_lists, {
         :todo_list  => :index
     }

     permission :create_todo_lists, {
         :todo_list  => :create,
         :todo_item  => :create
     }
     permission :update_todo_lists, {
         :todo_list  => :update,
         :todo_list  => :save_order
     }
     permission :delete_todo_lists, {
         :todo_list  => :delete
     }

     permission :create_todos, {
         :todo_list  => :create,
     }
     permission :update_todos, {
         :todo_item  => :update,
         :todo_item  => :toggle
     }
     permission :delete_todos, {
         :todo_item  => :delete
     }
  end

  #menu :project_menu, :todos, {:controller => 'todo_list', :action => 'index'}, :caption => :label_todo_plural, :param => :project_id, :after => :activity

end
