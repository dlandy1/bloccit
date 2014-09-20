class CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @comment = current_user.comments.build(params.require(:comment).permit( :body))
    @comment.post = @post
    authorize @comment
    if @comment.save
       render template: "posts/show", notice: "Comment was created successfully."
    else
      flash[:error] = "Error creating comment. It must be more than 5 characters. Please try again."
      render template: "posts/show"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @comment = @post.comments.find(params[:id])

    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed"
      render template: "posts/show"
    else
      flash[:error] = "Comment was not deleted. Try again."
      render template: "posts/show"
    end
  end

end
