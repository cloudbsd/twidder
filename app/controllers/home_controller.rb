class HomeController < ApplicationController
# before_filter :authenticate_user!

  def index
    if params[:set_locale]
      redirect_to root_path(locale: params[:set_locale])
    end
    flash[:notice] = t(:hello_flash, scope: 'home.index')
  end
end
