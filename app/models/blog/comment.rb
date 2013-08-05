class Blog::Comment < ActiveRecord::Base
  belongs_to :post, inverse_of: :comments

  def title
    content.try(:[], 0..20)
  end
end
