require 'rails_helper'

describe User do

  describe "#favorited(post)" do

  before do 
    @post = Post.create
    @user = User.create
  end

    it "returns 'nil' if the user has not favorited the post" do
      expect( @user.favorited(@post) ).to eq(nil)
    end

    it "returns the appropriate favorite if it exists" do
      favorite = @user.favorites.where(post: @post).create
      expect( @user.favorited(@post) ).to eq(favorite)
    end
  end
end