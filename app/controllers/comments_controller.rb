class CommentsController < ApplicationController
  respond_to :html, :js

  def create
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @comment = current_user.comments.build(params.require(:comment).permit( :body))
    @comment.post = @post
    authorize @comment
    if @comment.save
       redirect_to [@post.topic, @post], notice: "Comment was created successfully."
    else
      flash[:error] = "Error creating comment. It must be more than 5 characters. Please try again."
      render template: "topics/posts/show"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @comment = @post.comments.find(params[:id])

    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed"
    else
      flash[:error] = "Comment was not deleted. Try again."
    end

    respond_with(@comment) do |format|
      format.html { redirect_to [@post.topic, @post] }
    end

  end

end
