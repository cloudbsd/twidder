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
    if (params[:tree] == 'blob')
      @paths = params[:paths]
    # @reviews = Review.reviews_by_file(@project, @paths).paginate(page: params[:page], per_page: 20)
      @reviews = @project.reviews.paginate(page: params[:page], per_page: 20)
    elsif (params[:tree] == 'tree')
      @paths = params[:paths] ? (params[:paths].to_s + '/') : nil
    end

    # get entry list
    begin
      @repo = Grit::Repo.new(@project.path)
      @contents = @repo.tree('master',@paths).contents
      if (params[:tree] == 'blob')
        @blob = @contents.first
        redirect_to @project, notice: 'project blob path is wrong.' and return unless @blob
      else
        @blob = nil
        @entries = @contents
      end
    rescue Grit::GitRuby::Repository::NoSuchPath
      redirect_to @project, notice: 'project tree path is wrong.' and return
    rescue
      redirect_to @project and return
    end
  end
end
