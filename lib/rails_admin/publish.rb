require 'rails_admin/config/actions/base'

module RailsAdmin
  class Publish < RailsAdmin::Config::Actions::Base
    RailsAdmin::Config::Actions.register(self)

    register_instance_option :member do
      true
    end

    register_instance_option :http_methods do
      [:get, :post]
    end

    register_instance_option :controller do
      Proc.new do
        if request.post?
          @object.metadata['published'] = true
          if @object.save
            redirect_to_on_success
          else
            flash[:error] = "You probably screwed up smtg again: #{@object.errors.full_messages.to_sentence}"
          end
        end
      end
    end
  end
end


