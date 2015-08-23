require "fileutils"


class FileviewsController < ApplicationController
  unloadable


  helper :sort
  include SortHelper
  before_filter :require_login
   include AttachmentsHelper

  
  def index

 files = Fileuser.where(user_id: User.current.id, permission_flag:2).pluck(:attachment_id)
       files<<Fileuser.where(user_id: User.current.id, permission_flag:1).pluck(:attachment_id)

        filelist = []
       files.each do |f|
           unless filelist.include? f
                filelist<<f
           end    
       end

       
        @allFiles = LinkedFile.where(boxelement_id: filelist)
          

      if User.current.companies_id.present?
        @comapany_attachment_id =  Boxelement.where(:company_id => User.current.companies_id).pluck(:id) 

        @company_files = @allFiles.select {|c|  @comapany_attachment_id.include? c.boxelement_id}
        @project_files =  @allFiles.reject {|c|  @comapany_attachment_id.include? c.boxelement_id}

      else
        @project_files = @allFiles
      end
  end


  def visibility
  end
end
