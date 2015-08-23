class BoxelementsController < ApplicationController


  #menu_item :boxelements

  #before_filter :find_project_by_project_id
  # before_filter :authorize, :except => :create
  #helper :sort
  # include SortHelper



  # GET /boxelements
  # GET /boxelements.json
  def index
    @boxelements = Boxelement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boxelements }
    end
  end





  # GET /boxelements/1
  # GET /boxelements/1.json
  def show
    @boxelement = Boxelement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @boxelement }
    end
  end






  # GET /boxelements/new
  # GET /boxelements/new.json
  def new
    @boxelement = Boxelement.new

    #puts params[:project_id]
    #puts params[:author_id]


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @boxelement }
    end
  end





  # GET /boxelements/1/edit
  def edit
    @boxelement = Boxelement.find(params[:id])
  end






  # POST /boxelements
  # POST /boxelements.json
def create

  @boxelement = Boxelement.new(params[:boxelement])
  if @boxelement.name == ""
  else
    respond_to do |format|
      if @boxelement.save
          members = Member.where(project_id: params[:boxelement][:project_id]).pluck(:user_id) #find the users of the project


          permitted_users = []
          
          members.each do|m|
            if User.where(id: m).pluck(:login)==[]
              gusers = GroupsUser.where(group_id: m).pluck(:user_id) 
              gusers.each do |guser|
                permitted_users<<guser
              end
            else
              permitted_users<<m
            end
          end
          permitted_users.each do |per_user|
            FileMailer.send_email_file_user(per_user, @boxelement.name, @boxelement.id).deliver 
          end
    # for compnay
    if params[:boxelement][:company_id]
      company_users = User.where(companies_id: params[:boxelement][:company_id]).pluck(:id)
      # private_flag for company is 5
      if @boxelement.private_flag == 0
        company_users.each do |m|
          f = Fileuser.new
          f.user_id = m  
          f.attachment_id = @boxelement.id
          if m == User.current.id
            f.permission_flag = 2
          else
            f.permission_flag = 1
          end 

         f.save 

        end
      end

      if @boxelement.private_flag == 1
        company_users.each do |m|
        #filelist.each do |at|
        f = Fileuser.new
        f.user_id = m  
        f.attachment_id = @boxelement.id
        if m == User.current.id
              f.permission_flag = 2
        else
              f.permission_flag = 0
        end
        f.save  
        end
      end
  else
  
    if @boxelement.private_flag == 1
        permitted_users.each do |m|
        #filelist.each do |at|
          f = Fileuser.new
          f.user_id = m  
          f.attachment_id = @boxelement.id
          if m == User.current.id
                f.permission_flag = 2
          else
                f.permission_flag = 0
          end
          f.save  
        end
    end
                                          

    if @boxelement.private_flag==0
      permitted_users.each do |m|
        f = Fileuser.new
        f.user_id = m  
        f.attachment_id = @boxelement.id
        if m == User.current.id
          f.permission_flag = 2
        else
          f.permission_flag = 1
        end 

      f.save  
      end
    end
  end

=begin
    if @boxelement.private_flag==3
      permitted_users.each do |m|
        f = Fileuser.new
        f.user_id = m  
        f.attachment_id = @boxelement.id
        a = []
        @boxelement.customuser.split(',').each do|cuser|  
        a<<cuser.to_i
        end

          if m == User.current.id
            f.permission_flag = 2  
          else                                                                            
            a.each do|a|
              if m==a
                f.permission_flag = 1
              else 
                f.permission_flag = 0
              end
            end 
          f.save 
          end 
      end
    end
=end
    if params[:boxelement][:company_id] 
      #redirect_to '/fileviews'
      format.html { redirect_to fileviews_path, notice: 'File has been successfully uploaded' }
    else
      format.html { redirect_to project_files_path(@boxelement.project_id), notice: 'File has been successfully uploaded' }
      format.json { render json: @boxelement, status: :created, location: @boxelement }
    end
    
  else
   #new_project_boxelement_path(@project)
  redirect_to @boxelement
  end
  end
  end
end

  # PUT /boxelements/1
  # PUT /boxelements/1.json
  def update
    @boxelement = Boxelement.find(params[:id])

    respond_to do |format|
      if @boxelement.update_attributes(params[:boxelement])
                  
        format.html { redirect_to project_files_path(@boxelement.project_id), notice: 'File has been successfully uploaded' }
        #format.html { redirect_to @boxelement, notice: 'Boxelement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @boxelement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boxelements/1
  # DELETE /boxelements/1.json
  def destroy
    @boxelement = Boxelement.find(params[:id])
    @boxelement.destroy

    respond_to do |format|
      if @boxelement.project_id
      format.html {redirect_to project_files_path(@boxelement.project_id), notice: 'File has been deleted' }
      else
      format.html {redirect_to fileviews_path, notice: 'File has been deleted' }  
      #format.html { redirect_to boxelements_url }
      format.json { head :no_content }
      end
    end
  end
end
