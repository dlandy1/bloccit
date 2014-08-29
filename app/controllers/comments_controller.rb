class CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @comment = current_user.comments.build(params.require(:comment).permit( :body))
    @comment.post = @post
    authorize @comment
    if @comment.save
       redirect_to [@topic, @post], notice: "Comment was created successfully."
    else
      flash[:error] = "Error creating comment. It must be more than 5 characters. Please try again."
      redirect_to [@topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @comment = @post.comments.find(params[:id])

    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed"
      redirect_to [@topic, @post]
    else
      flash[:error] = "Comment was not deleted. Try again."
      redirect_to [@topic, @post]
    end
  end

end
