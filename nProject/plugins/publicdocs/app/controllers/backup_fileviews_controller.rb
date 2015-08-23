require "fileutils"


class FileviewsController < ApplicationController
  unloadable


  helper :sort
  include SortHelper
  before_filter :require_login
   include AttachmentsHelper

  
  def index


  @allFiles = Attachment.all  






  end
end
