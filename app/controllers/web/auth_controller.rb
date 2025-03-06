# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      @user = User.find_by(email: omniauth_user_email)
      @user ||= User.create!(email: omniauth_user_email, name: omniauth_user_name)

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

    def omniauth_user_email
      omniauth.info['email']
    end

    def omniauth_user_name
      omniauth.info['name'] || omniauth.info['nickname'] || default_user_name
    end

    def default_user_name
      if (last_user = User.where('name like ?', 'User %').last)
        _, number = last_user.name.split
        "User #{number.succ}"
      else
        'User 1'
      end
    end
  end
end
