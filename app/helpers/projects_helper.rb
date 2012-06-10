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
    attr_accessor :tree, :size, :date
    def initialize(tree, size, date)
      @tree = tree
      @size = size
      @date = date
    end
    def is_blob?
      !is_tree
    end
    def is_tree?
      @tree
    end
  end

  def fs_entry_status(entry)
    st = File.stat entry
    tree = File.directory?(entry)
    size = st.size
    gentry = GritShowEntry.new(tree, size, File.ctime(entry).to_s(:long))
    gentry
  end

  def fs_entry_basename(entry)
    File.basename(entry)
  end

  def fs_entry_path(entry, path)
    if path
      path += '/' unless path.end_with? "/"
      return path + entry
    else
      entry
    end
  end

  def grit_entry_basename entry
    entry.basename
  end

  def grit_entry_path entry
    entry.name
  end

  def grit_entry_status content
    tree = content.is_a?(Grit::Tree)
    size = content_size(content)
    head = @repo.log('master', content.name).first
    gentry = GritShowEntry.new(tree, size, head.date.to_s(:long))
    gentry
  end

  def repo_is_directory? content
    content.is_a? Grit::Tree
  end

# def committed_date path
#   head = @repo.log('master', path).first
#   head.date.to_s(:long)
# # head.date.strftime("%B %d, %Y")
# end

# def committed_message path
#   head = @repo.log('master', path).first
#   head.message
# end

# def committed_author path
#   head = @repo.log('master', path).first
#   head.author
# end

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

  def add_linenum(filename)
    File.open(filename, "r") do |file|
      linenum = 0
      newdata = "\n"
      file.each_line do |line|
        linenum += 1
        strnum = format("% 4d", linenum)
        prefix = link_to "#{strnum}", line_project_path(@project, 'line', @paths, linenum)
        newdata += prefix + ":  " + line
      end
      return newdata
    end
  end

# def grit_add_linenum(data)
#   linenum = 0
#   newdata = "\n"
#   data.each_line do |line|
#     linenum += 1
#     strnum = format("% 4d", linenum)
#     prefix = link_to "#{strnum}", line_project_path(@project, 'line', @paths, linenum)
#     newdata += prefix + ":  " + line
#   end
#   return newdata
# end

  def line_count(data)
    linenum = 0
    data.each_line do |line|
      linenum += 1
    end
    return linenum
  end

  def review_summary(filename, project, file)
    File.open(filename, "r") do |ffile|
      linenum = 0
      html_reviews = "\n"
      ffile.each_line do |line|
        linenum += 1
        prefix = link_to "#{linenum}", line_project_path(@project, 'line', @paths, linenum)
        reviews = Review.with_project(project).with_file(file).with_line(linenum)
      # reviews = project.reviews_by_line(file, linenum)
        html_reviews += "<p>#{reviews.count} reviews for #{prefix} line.</p>" if reviews.any?
      end
      return html_reviews
    end
  end

# def grit_review_summary(data, project, file)
#   linenum = 0
#   html_reviews = "\n"
#   data.each_line do |line|
#     linenum += 1
#     prefix = link_to "#{linenum}", line_project_path(@project, 'line', @paths, linenum)
#     reviews = Review.with_project(project).with_file(file).with_line(linenum)
#   # reviews = project.reviews_by_line(file, linenum)
#     html_reviews += "<p>#{reviews.count} reviews for #{prefix} line.</p>" if reviews.any?
#   end
#   return html_reviews
# end
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
