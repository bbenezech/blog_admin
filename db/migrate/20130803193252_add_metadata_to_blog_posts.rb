class AddMetadataToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :metadata, :text
  end
end
