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
    items << NavItem.new(t(".home"), users_mine_path, "users" == params[:controller] && "mine" == params[:action])
    items << NavItem.new(t(".users"), users_path, "users" == params[:controller] && "index" == params[:action])
    items << NavItem.new(t(".microposts"), microposts_path, "microposts" == params[:controller])
    items << NavItem.new(t(".microgroups"), microgroups_path, "microgroups" == params[:controller])
    items << NavItem.new(t(".projects"), projects_path, "projects" == params[:controller])
    items << NavItem.new(t(".blogs"), posts_path, "posts" == params[:controller])
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

  def bootstrap_error_messages!(object)
    return "" if object.errors.empty?

    messages = object.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => object.errors.count,
                      :resource => object.class.model_name.human.downcase)

    html = <<-HTML
    <div class="alert alert-error alert-block fade in">
      <a class="close" data-dismiss="alert">&times;</a>
      <h4 class="alert-heading">#{sentence}</h4>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end
