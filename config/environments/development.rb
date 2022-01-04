require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  # config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.hosts.clear

  ENV['GOOGLE_OAUTH_CLIENT_ID'] = '978243226021-u5asf2a2ueffk0khbtband8512gu6nhj.apps.googleusercontent.com'
  ENV['GOOGLE_OAUTH_CLIENT_SECRET'] = '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'

  ENV['CLIENT_ID']='io.ngrok.c6ef-112-196-25-164.loginapple'
  ENV['KEY_ID']='H9P6X5892X'
  ENV['TEAM_ID']='CGYHFCCU8D'
  ENV['APPLE_PRIATE_KEY']='LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JR1RBZ0VBTUJNR0J5cUdTTTQ5QWdFR0NDcUdTTTQ5QXdFSEJIa3dkd0lCQVFRZ1VacUJBemtoUnFhRi9zNEIKV1I3SFgyS0RKdDdWVlVjMjk4cUFMMmgyN3ppZ0NnWUlLb1pJemowREFRZWhSQU5DQUFRQ01HdlhrcENYci9SMQpZMTYxT0dZT1NHQlpwbjgvUmcxS2h1N2k1Wkk4VHUvZG5adDZtN2U0aWlIQlFpQXA1L2g1QkZkMkVIQWhDUXI2CkFVM1JnNG1rCi0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0'
  ENV['APPLE_REDIRECT_URI']='http://localhost:3000/'



  # Rails.application.config.middleware.use OmniAuth::Builder do
  #   provider :apple, ENV['CLIENT_ID'], '',
  #            {
  #              scope: 'email name',
  #              team_id: ENV['TEAM_ID'],
  #              key_id: ENV['KEY_ID'],
  #              pem: ENV['PRIVATE_KEY']
  #            }
  # end
  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  config.hosts.clear

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true
end
