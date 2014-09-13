class VotesController < ApplicationController

  before_filter :authenticate_user!

  before_action :load_post_and_vote

  def up_vote
    if @post.already_up_voted_by_user?(current_user)
      flash[:error] = "You already upvoted the post."
      redirect_to :back
    elsif @post.already_down_voted_by_user?(current_user)
      @post.remove_down_vote!(current_user)
      @post.up_vote!(current_user)
      redirect_to :back
    else
      @post.up_vote!(current_user)
      redirect_to :back
    end
  end

  def down_vote
    if @post.already_down_voted_by_user?(current_user)
      flash[:error] = "You already downvoted the post."
      redirect_to :back
    elsif @post.already_up_voted_by_user?(current_user)
      @post.remove_up_vote!(current_user)
      @post.down_vote!(current_user)
      redirect_to :back
    else
      @post.down_vote!(current_user)
      redirect_to :back
    end
  end

  private

    def load_post_and_vote
      @post = Post.find(params[:post_id])
      @topic = @post.topic
    end

end