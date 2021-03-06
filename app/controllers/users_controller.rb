class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:mine]

  # GET /users
  # GET /users.json
  def index
  # @users = User.all
    @users = User.paginate(page: params[:page], per_page: 20)

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def mine
    @user = current_user
  # @micropost = @user.microposts.build
    @microposts = @user.feed.paginate(page: params[:page], per_page: 20)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  # @micropost = @user.microposts.build
    @microposts = @user.microposts.page(params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def followees
    @user = User.find(params[:id])
    @users = @user.followees.page(params[:page])
    render 'index'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'index'
  end
end
