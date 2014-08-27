class CommentsController < ApplicationController
  
  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(params.require(:comment).permit( :body))
    @comment.post = @post
    authorize @comment
    if @comment.save
       redirect_to [@topic, @post], notice: "Comment was created successfully."
    else
      flash[:error] = "Error creating comment. Please try again."
    end
  end

end
