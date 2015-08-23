class InvitesController < ApplicationController
  # GET /invites
  # GET /invites.json
  def index
    @invites = Invite.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invites }
    end
  end

  # GET /calls/1
  # GET /calls/1.json
  def show
    @invite = Invite.find(params[:id])
    print "start from here "
    @values = [] 
    @login = []

  for invitee in @invite.invitees 
        invitee.name.split(',').each do |key|
        @values << User.where(id: key).pluck(:firstname)
         end
    end 
    puts @values
     



    #respond_to do |format|
      #format.html # show.html.erb
      #format.json { render json: @invite }
   #end
  end


  # GET /invites/new
  # GET /invites/new.json
  def new
    @invite = Invite.new
    1.times {@invite.invitees.build}
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invite }
      format.js
    end
  end

  # GET /calls/1/edit
  def edit
    @invite = Invite.find(params[:id])
  end

  # POST /calls
  # POST /calls.json
  def create
    @invite = Invite.new(params[:invite])


    @ids =[]


=begin
    @inviteList = Invitee.all

    @inviteList.each do |k|
          @ids << k;
          puts "invite: "
          puts k.name

    end
=end
    respond_to do |format|
      if @invite.save
        puts "invitee :"
        @check = Invitee.last
        
        @inviteeList = []
   


        @check.name.split(',').each do |key|
      #  @values << User.select(:mail).where(id: key)
       @inviteeList << key.to_i
       

         end





         mailList = []


         @inviteeList.each do |i|
          mailList << User.where(id: i).pluck(:mail)
 
         end
                  

    
         @inviteeList.each do |j|
          Guest.create(name: j, invitee_id: Invitee.last.id);
         end




        InviteMailer.invitation_to_member(mailList)
        format.html { redirect_to @invite, notice: 'Invite was successfully created.' }
        format.json { render json: @invite, status: :created, location: @invite }
      else
        format.html { render action: "new" }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /calls/1
  # PUT /calls/1.json
  def update
    @invite = Invite.find(params[:id])

    respond_to do |format|
      if @invite.update_attributes(params[:call])
        format.html { redirect_to @invite, notice: 'Call was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calls/1
  # DELETE /calls/1.json
  def destroy
    @invite = Invite.find(params[:id])
    @invite.destroy

    respond_to do |format|
      format.html { redirect_to calls_url }
      format.json { head :no_content }
      format.js
    end
  end
end
