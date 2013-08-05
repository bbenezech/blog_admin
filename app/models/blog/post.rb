class Blog::Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  accepts_nested_attributes_for :comments

  serialize :metadata, Hash

  rails_admin do
    configure :metadata do
      hide
    end

    configure :user do
      visible do
        bindings[:controller].current_ability.can? :edit, User
      end
    end

    configure :comments do
      visible do
        bindings[:controller].current_ability.can? :edit, Blog::Comment
      end
    end

    configure :block, :metadata
    configure :sticky, :metadata do
      view_helper :check_box
    end
    configure :published, :metadata do
      view_helper :check_box
    end
    configure :priority, :metadata do
      view_helper :number_field
      default_value 0
    end
  end
end


