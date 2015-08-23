class CrutilsController < ApplicationController
  def index

    #@resource_util = Rutil.all
  	@project = Project.find(params[:project_id])
  	#@resource_util = Rutil.find(:all) # @project.polls
end
end
end
