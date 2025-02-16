# frozen_string_literal: true

module Web
  class ProfileController < ApplicationController
    def show
      authorize :profile

      @q = current_user.bulletins.order(created_at: :desc).ransack(params[:q])
      @bulletins = @q.result.page(params[:page])
    end
  end
end
