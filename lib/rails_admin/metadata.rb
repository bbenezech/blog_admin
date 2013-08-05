require 'rails_admin/config/fields/base'

module RailsAdmin
  class Metadata < RailsAdmin::Config::Fields::Base
    RailsAdmin::Config::Fields::Types::register(self)

    def value
      raise 'No metadata!' unless bindings[:object].respond_to?(:metadata)
      bindings[:object].metadata[method_name]
    end

    def allowed_methods
      'metadata'
    end

    def parse_input(params)
      params['metadata'] ||= bindings[:object].metadata
      params['metadata'][method_name] = params.delete(method_name)
    end
  end
end


