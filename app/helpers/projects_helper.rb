module ProjectsHelper
  class BreakScrumbPath
    attr_accessor :name, :link, :active

    def initialize(name, link, active)
      @name = name
      @link = link
      @active = active
    end
  end

  def breakscrumb_paths path
    bspaths = []
    bspaths << BreakScrumbPath.new("Root", nil, false)
    if path
      paths = path.split('/')
      path = ""
      paths.each do |p|
        path += "/" unless path == ""
        path += p
        bspaths << BreakScrumbPath.new(p, path, false)
      end
    end
    bspaths.last.active = true
    bspaths
  end

  def parent_path path
    if path
      path.chop! if path.end_with? "/"
      path = path.rpartition("/").first
      path = nil if path.empty?
    end
    path
  end

  class GritShowEntry
    attr_accessor :tree, :size, :date, :author
    def initialize(tree, size, date, author)
      @tree = tree
      @size = size
      @date = date
      @author = author
    end
    def is_blob?
      !is_tree
    end
    def is_tree?
      @tree
    end
  end

  def grit_entry_status content
    tree = content.is_a?(Grit::Tree)
    size = content_size(content)
    head = @repo.log('master', content.name).first
    gentry = GritShowEntry.new(tree, size, head.date.to_s(:long), head.author)
    gentry
  end

  def repo_is_directory? content
    content.is_a? Grit::Tree
  end

  def committed_date path
    head = @repo.log('master', path).first
    head.date.to_s(:long)
  # head.date.strftime("%B %d, %Y")
  end

  def committed_message path
    head = @repo.log('master', path).first
    head.message
  end

  def committed_author path
    head = @repo.log('master', path).first
    head.author
  end

  def content_type content
    if content.is_a? Grit::Tree
      "directory"
    elsif content.is_a? Grit::Blob
      content.mime_type
    else
      "Unknown"
    end
  end

  def content_size content
    if content.is_a? Grit::Blob
      content.size.to_s
    else
      "--"
    end
  end
end


=begin
<table>
  <tr>
    <th>Name</th>
    <th>Size</th>
    <th>Type</th>
    <th>Last Modified</th>
    <th></th>
  </tr>

<% Dir::foreach(@project.path) do |f| %>
  <% next if f == '.' %>
  <% filepath = item_path(@project.path, f) %>
  <% st = File.stat(filepath) %>
  <tr>
    <td><%= link_to_if st.directory?, f, project_path(@project, :paths => filepath) %></td>
    <td><%= st.size?() %></td>
    <td><%= st.ftype %></td>
    <td><%= st.mtime %></td>
    <td><%= link_to 'Edit', edit_project_path(@project) %></td>
  </tr>
<% end %>
</table>
=end
