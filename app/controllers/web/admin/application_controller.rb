# frozen_string_literal: true

module Web
  module Admin
    class ApplicationController < Web::ApplicationController
      before_action :authenticate_admin!

      private

      def authenticate_admin!
        return if current_user&.admin?

        flash[:alert] = t('flashes.not_authorized')
        redirect_to root_path
      end
    end
  end
end
