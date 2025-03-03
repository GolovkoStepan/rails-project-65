# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      @user = User.find_or_create_by!(email: omniauth.info['email'], name: omniauth.info['name'])
      session[:user_id] = @user.id

      redirect_to root_path
    rescue StandardError => e
      Rails.logger.error("Callback info: #{omniauth.info} Auth error: #{e.message}")

      redirect_to root_path, alert: t('shared.auth.error')
    end

    def logout
      session[:user_id] = nil

      redirect_to root_path
    end

    private

    def omniauth
      request.env['omniauth.auth']
    end
  end
end
