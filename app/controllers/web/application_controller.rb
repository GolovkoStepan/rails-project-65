# frozen_string_literal: true

module Web
  class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    helper_method :current_user, :user_signed_in?

    def authenticate_user!
      redirect_to root_path, alert: 'Requires authentication' unless user_signed_in?
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
    end

    def user_signed_in?
      session[:user_id].present? && current_user.present?
    end
  end
end
