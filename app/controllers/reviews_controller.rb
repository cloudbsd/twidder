class ReviewsController < ApplicationController
  # POST /projects/1/reviews
  # POST /projects/1/reviews.json
  def create
    @project = Project.find(params[:project_id])
    @review = @project.reviews.build(params[:review])
    @review.user = current_user

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Review was successfully created.' }
        format.js
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1/reviews/1
  # DELETE /projects/1/reviews/1.json
  def destroy
    @project = Project.find(params[:project_id])
    @review = @project.reviews.find(params[:id])
    paths = @review.file
    @review.destroy

    respond_to do |format|
      format.html { redirect_to blob_project_path(@project, 'blob', paths) }
      format.js
      format.json { head :no_content }
    end
  end
end
