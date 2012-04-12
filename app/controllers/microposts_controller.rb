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
  # @micropost = Micropost.new(params[:micropost])
    @micropost = current_user.microposts.build(params[:micropost])
  # @micropost.group_id = 0
    @group = nil

    respond_to do |format|
      if @micropost.save
        format.html { redirect_to users_mine_path, notice: 'Micropost was successfully created.' }
      # format.html { redirect_to @micropost, notice: 'Micropost was successfully created.' }
      # format.json { render json: @micropost, status: :created, location: @micropost }
      else
        format.html { render action: "new" }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy

    respond_to do |format|
      format.html { redirect_to microposts_url }
      format.json { head :no_content }
    end
  end
end
