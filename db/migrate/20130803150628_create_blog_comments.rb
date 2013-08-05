class CreateBlogComments < ActiveRecord::Migration
  def change
    create_table :blog_comments do |t|
      t.text :content
      t.belongs_to :post, index: true

      t.timestamps
    end
  end
end
