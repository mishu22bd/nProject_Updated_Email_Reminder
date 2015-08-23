class ImdashsController < ApplicationController
  unloadable
before_filter :require_login
  

  caches_action :robots
  helper :issues

  helper :projects
  helper :queries
  include QueriesHelper
  helper :sort
  include SortHelper
   
    def index
        scope = Project
        
        

        #@projectss = scope.visible.order('lft').all
        #@projectss = @projectss
        @projects = Project.latest User.current
        #Rails.logger.info "DEBUG STARTED"
        @projectss = User.current.memberships.collect(&:project).compact.select(&:active?).uniq
        #puts @projectss
        #Rails.logger.info "DEBUG END"
        @news = News.latest User.current
        @users = User.all
        
       # Rails.logger.info "Start Debugging"
       
        @persons = Person.all.reverse
        
       # Rails.logger.info "Persons data #{@persons}"
       # Rails.logger.info "End Debugging"

        @issues  = Issue.order("created_on DESC").all
        userCurrent = User.current.id
        @issuesAssignedToMeOriginal = Issue.where assigned_to_id: User.current.id
        @issuesAssignedToMe= @issuesAssignedToMeOriginal.where tracker_id: 5
        @issuesAssignedToMe = @issuesAssignedToMe.where(status_id: [1,2,3,4])
        @issuesAssignedToMe = @issuesAssignedToMe.reverse
      

        @tasksAssignedToMeOriginal = Issue.where assigned_to_id: User.current.id
        @tasksAssignedToMe = @tasksAssignedToMeOriginal.where tracker_id: 4 
        @tasksAssignedToMe = @tasksAssignedToMe.where(status_id: [1,2,3,4])
        @tasksAssignedToMe = @tasksAssignedToMe.reverse
        
        #@tasks = TodoList.all

        @allFiles = Attachment.all.reverse  
        
       # @callers = Caller.all
        @year ||= Date.today.year #returns 2013
      
        @month ||= Date.today.month #returns 12
        @calendarLocal = Redmine::Helpers::Calendar.new(Date.civil(@year,@month), current_language, :week)
        print @calendarLocal
        retrieve_query
        @query.group_by = nil
        if @query.valid?
           events = []
           events += @query.issues(:include => [:tracker, :assigned_to, :priority],
                                  :conditions => ["((start_date BETWEEN ? AND ?) OR (due_date BETWEEN ? AND ?))", @calendarLocal.startdt, @calendarLocal.enddt, @calendarLocal.startdt, @calendarLocal.enddt]
                                  )
           events += @query.versions(:conditions => ["effective_date BETWEEN ? AND ?", @calendarLocal.startdt, @calendarLocal.enddt])#

       @calendarLocal.events = events

       

    end

  end


def robots
    @projects = Project.all_public.active
    render :layout => false, :content_type => 'text/plain'
  end

  


end
