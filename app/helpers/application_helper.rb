module ApplicationHelper
  class NavItem
    attr_accessor :name, :link, :active

    def initialize(name, link, active)
      @name = name
      @link = link
      @active = active
    end
  end

  def show_nav_items
    items = [];
    items << NavItem.new("Users", '#', "users" == params[:controller])
    items << NavItem.new("Microgroups", '#', "microgroups" == params[:controller])
    items << NavItem.new("Microposts", '#', "microposts" == params[:controller])
    items << NavItem.new("Project", '#', "projects" == params[:controller])
    items << NavItem.new("Blog", '#', "posts" == params[:controller])
  end
end
