class MicrogroupsController < ApplicationController
  # GET /microgroups
  # GET /microgroups.json
  def index
    @microgroups = Microgroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @microgroups }
    end
  end

  # GET /microgroups/1
  # GET /microgroups/1.json
  def show
    @microgroup = Microgroup.find(params[:id])
  # @group = @microgroup.group
    @users = @microgroup.group.users
    @micropost = @microgroup.group.microposts.build
  # @microposts = @microgroup.microposts
    @microposts = @microgroup.group.microposts.paginate(page: params[:page], per_page: 10)
  # @users = User.paginate(page: params[:page], per_page: 20)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @microgroup }
    end
  end

  # GET /microgroups/new
  # GET /microgroups/new.json
  def new
    @microgroup = Microgroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @microgroup }
    end
  end

  # GET /microgroups/1/edit
  def edit
    @microgroup = Microgroup.find(params[:id])
  end

  # POST /microgroups
  # POST /microgroups.json
  def create
    @microgroup = Microgroup.new(params[:microgroup])

    respond_to do |format|
      if @microgroup.save
        format.html { redirect_to @microgroup, notice: 'Microgroup was successfully created.' }
        format.json { render json: @microgroup, status: :created, location: @microgroup }
      else
        format.html { render action: "new" }
        format.json { render json: @microgroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /microgroups/1
  # PUT /microgroups/1.json
  def update
    @microgroup = Microgroup.find(params[:id])

    respond_to do |format|
      if @microgroup.update_attributes(params[:microgroup])
        format.html { redirect_to @microgroup, notice: 'Microgroup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @microgroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microgroups/1
  # DELETE /microgroups/1.json
  def destroy
    @microgroup = Microgroup.find(params[:id])
    @microgroup.destroy

    respond_to do |format|
      format.html { redirect_to microgroups_url }
      format.json { head :no_content }
    end
  end
end
