require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Testapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    # CORS設定の追加
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'https://alc-streamersland.com'
        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head],
          credentials: true  # 認証情報を含める場合にtrueを設定
      end
    end
    


    # その他の設定
    config.paths.add 'lib', eager_load: true
  end
end