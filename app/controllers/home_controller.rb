class HomeController < ApplicationController
# before_filter :authenticate_user!

  def index
    if params[:set_locale]
      redirect_to root_path(locale: params[:set_locale])
    end
    flash[:notice] = t(:hello_flash, scope: 'home.index')

    @recent_users = User.limit(16)
    @recent_microposts = Micropost.limit(5)
    @top10_users = User.limit(10)
  # @top10_groups = Group.limit(8)
  end
end
