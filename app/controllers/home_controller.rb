class HomeController < ApplicationController
# before_filter :authenticate_user!

  def index
    flash[:notice] = t(:hello_flash, scope: 'home.index')
  end
end
