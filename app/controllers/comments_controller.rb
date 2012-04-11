class CommentsController < ApplicationController
  # POST /posts/1/comments
  # POST /posts/1/comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Comment was successfully created.' }
        format.js   { @current_comment = @comment }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1/comments/1
  # DELETE /posts/1/comments/1.json
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @post }
      format.js
      format.json { head :no_content }
    end
  end
end
