# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session  # CSRF保護を無効化
  end