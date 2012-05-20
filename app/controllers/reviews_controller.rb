class ReviewsController < ApplicationController
  before_filter :authenticate_user!

  # POST /projects/1/reviews
  # POST /projects/1/reviews.json
  def create
    @project = Project.find(params[:project_id])
    @review = @project.reviews.build(params[:review])
    @review.user = current_user
    @paths = @review.file
    @line = @review.line

    respond_to do |format|
      if @review.save
        format.html { redirect_to line_project_path(@project, 'line', @paths, @line), notice: 'Review was successfully created.' }
        format.js { @reviews = @project.reviews_by_line(@paths, @line).paginate(page: params[:page], per_page: 20) }
        format.json { render json: @review, status: :created, location: @review }
      else
        format.html { render action: "new" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1/reviews/1
  # DELETE /projects/1/reviews/1.json
  def destroy
    @project = Project.find(params[:project_id])
    @review = @project.reviews.find(params[:id])
    @paths = @review.file
    @line = @review.line
    @review.destroy

    respond_to do |format|
    # format.html { redirect_to blob_project_path(@project, 'blob', @paths) }
      format.html { redirect_to line_project_path(@project, 'line', @paths, @line) }
      format.js { @reviews = @project.reviews_by_line(@paths, @line).paginate(page: params[:page], per_page: 20) }
      format.json { head :no_content }
    end
  end

  # GET /reviews/1/up
  # GET /reviews/1/up.json
  def up
    @review = Review.find(params[:id])
    @vote = @review.votes.build(params[:vote])
    @vote.user = current_user
    @vote.point = 1

    @paths = @review.file
    @line = @review.line
    @project = @review.project

    respond_to do |format|
      if @review.save
        format.html { redirect_to line_project_path(@project, 'line', @paths, @line), notice: 'Vote was successfully created.' }
        format.js { @reviews = @project.reviews_by_line(@paths, @line).paginate(page: params[:page], per_page: 20) }
        format.json { render json: @review, status: :created, location: @review }
      else
        format.html { render action: "new" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /reviews/1/down
  # GET /reviews/1/down.json
  def down
    @review = Review.find(params[:id])
    @vote = @review.votes.build(params[:vote])
    @vote.user = current_user
    @vote.point = -1

    @paths = @review.file
    @line = @review.line
    @project = @review.project

    respond_to do |format|
      if @review.save
        format.html { redirect_to line_project_path(@project, 'line', @paths, @line), notice: 'Vote was successfully created.' }
        format.js { @reviews = @project.reviews_by_line(@paths, @line).paginate(page: params[:page], per_page: 20) }
        format.json { render json: @review, status: :created, location: @review }
      else
        format.html { render action: "new" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end
end
