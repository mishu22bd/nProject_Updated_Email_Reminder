class CompaniesController < ApplicationController
  unloadable
  before_filter :set_company, :only => [:show, :edit, :update, :destroy ]
  before_filter :require_login
  caches_action :robots
  helper :issues
  include IssuesHelper
  #helper :projects
  helper :queries
  include QueriesHelper
  helper :members 
  helper :users
 
  def index
    if Consultant.consultant? User.current.id
      ids = Consultant.company_id User.current.id
      @companies = ids.collect {|i| Company.find(i)}
    else
      @companies = Company.all
    end
  end
# responsible for showing company data
  def show
    @users = @company.users.all
    @projects = @company.projects.all
    ids = Consultant.ids(params[:id])
    
    @consultants = consultants ids
    
  end
  def company_data
    @user = User.current
    @company = Company.find(@user.companies_id)

  end

  def new
    @company =  Company.new
  end

  def create
    @company = Company.new(params[:company])
    
    if @company.save
     flash[:notice] = "Successfully saved"

    else
     render 'new'
     end 
  end

  def edit
   # @company =  @company = Company.find(params[:id])
  end

  

  def update
   # @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
       flash[:notice] = "Successfully updated"
    else
      render 'edit'
    end
    if params[:redirect_location]
      redirect_to params[:redirect_location]
    else 
      redirect_to companies_path
    end
  end

  def destroy
   #@company = Company.find(params[:id])
    if @company.destroy
      flash[:notice] = "Company deleted"
      redirect_to companies_path
    end
  end
  
  private
  
  def consultants ids
    ids.collect {|i| User.find(i) }
  end
   def set_company
     @company = Company.find(params[:id])
   end

end

