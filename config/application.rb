require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Flux
  class Application < Rails::Application
    
      config.to_prepare do
        Devise::SessionsController.layout 'admin_lte_2_login'
      end
      
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.generators do |g|
        g.test_framework  :rspec, :fixture => false
        g.view_specs      false
        g.helper_specs    false
        g.template_engine :haml
    end

    config.time_zone = "Nairobi"
    config.active_record.default_timezone = :local
  end
end
