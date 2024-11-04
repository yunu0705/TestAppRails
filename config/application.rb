# config/application.rb

require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Testapp
  class Application < Rails::Application
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
  end
end
