# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    skip_before_action :authenticate_user!, only: :callback

    def callback
      @user = User.find_or_create_by(email: omniauth.info['email'], name: omniauth.info['name'])
      session[:user_id] = @user.id if @user.persisted?

      redirect_to root_path
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
