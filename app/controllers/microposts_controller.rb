class MicropostsController < ApplicationController
  before_filter :authenticate_user!

  # GET /microposts
  # GET /microposts.json
  def index
  # @microposts = Micropost.all
    @microposts = Micropost.paginate(page: params[:page], per_page: 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @microposts }
    end
  end

  # GET /microposts/new
  # GET /microposts/new.json
  def new
    @micropost = Micropost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @micropost }
    end
  end

  # POST /microposts
  # POST /microposts.json
  def create
    @group = nil
    @group = current_user.microgroups.find(params[:microgroup_id]).group unless params[:microgroup_id].nil?
  # @micropost = Micropost.new(params[:micropost])
    @micropost = current_user.microposts.build(params[:micropost])
    if @group
      @micropost.group = @group
    else
      @micropost.group_id = 0
    end

    respond_to do |format|
      if @micropost.save
        if @group
          format.html { redirect_to @group.microgroup, notice: 'Micropost was successfully created.' }
          format.js   { @microposts = @group.microposts.paginate(page: params[:page], per_page: 10) }
          format.json { render json: @group.microgroup, status: :created, location: @microgroup }
        else
          format.html { redirect_to users_mine_path, notice: 'Micropost was successfully created.' }
          format.js   { @microposts = current_user.feed.paginate(page: params[:page], per_page: 20) }
          format.json { render json: @micropost, status: :created, location: @micropost }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @group = current_user.microgroups.find(params[:microgroup_id]).group unless params[:microgroup_id].nil?
  # @micropost = Micropost.find(params[:id])
    @micropost = current_user.microposts.find(params[:id])
    @micropost.destroy unless @micropost.nil?

    respond_to do |format|
      if @group
        format.html { redirect_to @group.microgroup }
        format.js   { @microposts = @group.microposts.paginate(page: params[:page], per_page: 10) }
        format.json { head :no_content }
      else
        format.html { redirect_to microposts_url }
        format.js   { @microposts = current_user.feed.paginate(page: params[:page], per_page: 20) }
        format.json { head :no_content }
      end
    end
  end
end
