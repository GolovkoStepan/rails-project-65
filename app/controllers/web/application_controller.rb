# frozen_string_literal: true

module Web
  class ApplicationController < ActionController::Base
    include Pundit::Authorization

    helper_method :current_user, :user_signed_in?

    rescue_from Pundit::NotAuthorizedError, with: :not_authorized_handler

    private

    def not_authorized_handler(exception)
      policy_name = exception.policy.class.to_s.underscore
      alert = t "#{policy_name}.#{exception.query}", scope: :pundit, default: :default

      redirect_back(fallback_location: root_path, alert:)
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
    end

    def user_signed_in?
      session[:user_id].present? && current_user.present?
    end
  end
end
