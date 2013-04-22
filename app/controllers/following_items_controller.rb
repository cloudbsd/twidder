class FollowingItemsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @user = User.find(params[:following_item][:followee_id])
    current_user.follow(@user)

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = FollowingItem.find(params[:id]).followee
    current_user.unfollow(@user)

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
