require 'rails_helper'

describe User do
  
  include TestFactories

  before do 
    @post = associated_post
    @user = authenticated_user
    sign_in @user
  end

  describe "#favorited(post)" do
    it "returns 'nil' if the user has not favorited the post" do
      expect( @user.favorites.find_by_post_id(@post.id) ).to eq(nil)
    end

    it "returns the appropriate favorite if it exists" do
      expect( @user.favorites.find_by_post_id(@post.id) ).to eq(Favorite)
    end
  end
end