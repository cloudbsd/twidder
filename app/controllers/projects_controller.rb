class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    show_tree or return

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
  # @project = Project.new(params[:project])
    grp = Group.create!(name: params[:project][:name], description: params[:project][:description])
    @project = current_user.projects.build(params[:project])
    @project.group = grp

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private

  def show_tree
    # get correct path for tree or blob
    if (params[:tree] == 'blob' || params[:tree] == 'line')
      @paths = params[:paths]
      if params[:tree] == 'line'
        @line = params[:line]
        @reviews = Review.with_project(@project).with_file(@paths).with_line(@line).paginate(page: params[:page], per_page: 20)
      else
        @line = nil
        @reviews = []
      end
    elsif (params[:tree] == 'tree')
      @paths = params[:paths] ? (params[:paths].to_s + '/') : nil
    end

    @absolute_path = @project.path
    @absolute_path += '/' unless @absolute_path.end_with? '/'
    @absolute_path += @paths if @paths

    if (params[:tree] == 'blob' || params[:tree] == 'line')
      @blob = @absolute_path
      redirect_to @project, notice: 'project blob path is wrong.' and return unless File.exist? @blob
    else
      @blob = nil
      @entries = Dir.entries(@absolute_path)
      @entries.delete "."
      @entries.delete ".."
    end

    logger.info "+++++++++++++++++++++++++++++++++++++"
    logger.info params
    logger.info "+++++++++++++++++++++++++++++++++++++"
    logger.info @absolute_path
    logger.info "+++++++++++++++++++++++++++++++++++++"
    logger.info @paths
    logger.info "+++++++++++++++++++++++++++++++++++++"
    logger.info @blob
    logger.info "+++++++++++++++++++++++++++++++++++++"

#   # get entry list
#   begin
#     @repo = Grit::Repo.new(@project.path)
#     @contents = @repo.tree('master',@paths).contents
#     if (params[:tree] == 'blob' || params[:tree] == 'line')
#       @blob = @contents.first
#       redirect_to @project, notice: 'project blob path is wrong.' and return unless @blob
#     else
#       @blob = nil
#       @entries = @contents
#     end
#   rescue Grit::GitRuby::Repository::NoSuchPath
#     redirect_to @project, notice: 'project tree path is wrong.' and return
#   rescue
#     redirect_to @project and return
#   end
  end

# def show_tree
#   # get correct path for tree or blob
#   if (params[:tree] == 'blob' || params[:tree] == 'line')
#     @paths = params[:paths]
#     if params[:tree] == 'line'
#       @line = params[:line]
#       @reviews = Review.with_project(@project).with_file(@paths).with_line(@line).paginate(page: params[:page], per_page: 20)
#     else
#       @line = nil
#       @reviews = []
#     end
#   elsif (params[:tree] == 'tree')
#     @paths = params[:paths] ? (params[:paths].to_s + '/') : nil
#   end

#   # get entry list
#   begin
#     @repo = Grit::Repo.new(@project.path)
#     @contents = @repo.tree('master',@paths).contents
#     if (params[:tree] == 'blob' || params[:tree] == 'line')
#       @blob = @contents.first
#       redirect_to @project, notice: 'project blob path is wrong.' and return unless @blob
#     else
#       @blob = nil
#       @entries = @contents
#     end
#   rescue Grit::GitRuby::Repository::NoSuchPath
#     redirect_to @project, notice: 'project tree path is wrong.' and return
#   rescue
#     redirect_to @project and return
#   end
# end
end
