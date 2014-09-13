class AddPostToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :post_id, :integer
  end
end
