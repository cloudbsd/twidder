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
    items << NavItem.new("Users", users_path, "users" == params[:controller])
    items << NavItem.new("Microgroups", '#', "microgroups" == params[:controller])
    items << NavItem.new("Microposts", '#', "microposts" == params[:controller])
    items << NavItem.new("Project", '#', "projects" == params[:controller])
    items << NavItem.new("Blog", '#', "posts" == params[:controller])
  end

  def form_error_messages!(object)
    return "" if object.errors.empty?

    messages = object.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => object.errors.count,
                      :resource => object.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end
