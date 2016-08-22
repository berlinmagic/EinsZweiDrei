require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# load app configuration
app_yaml_data = YAML.load(File.read(File.expand_path('../configuration.yml', __FILE__)))
CONFIG = HashWithIndifferentAccess.new(app_yaml_data)
CONFIG.merge! CONFIG.fetch(Rails.env, {})


module EinsZweiDrei
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    ## additional Assets
    config.assets.precompile += %w( plugins/highcharts_custom.js )
    config.assets.precompile += %w( email.css )
    config.assets.precompile += %w( game.css )
    config.assets.precompile += %w( game.js )

    ## TimeZone
    config.time_zone = 'Berlin'

    ## default locale
    config.i18n.default_locale = :de

    ## rewrite gem layout and helper
    config.to_prepare do
      Devise::Mailer.helper "application"
      Devise::Mailer.layout "mailer"
      ## change layout in all controller:
      # DeviseController.layout proc { |controller| controller.request.xhr? ? 'xhr' : "application" }
      ## change layout in single controllers:
      # Devise::SessionsController.layout proc { |controller| controller.request.xhr? ? 'xhr' : "application" }
      # Devise::RegistrationsController.layout proc { |controller| controller.request.xhr? ? 'xhr' : "application" }
    end

  end
end
