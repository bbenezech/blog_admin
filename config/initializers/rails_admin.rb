require 'rails_admin/metadata'
require 'rails_admin/publish'

RailsAdmin.config do |config|
  config.current_user_method &:current_user
  config.authorize_with :cancan

  config.actions do
    # root actions
      dashboard                     # mandatory
    # collection actions 
      index                         # mandatory
      new
      export
      history_index
      bulk_delete
    # member actions
      show
      edit
      delete
      history_show
      show_in_app

      publish do
        only 'Blog::Post'
        link_icon 'icon-check'
      end

      
  end
end
