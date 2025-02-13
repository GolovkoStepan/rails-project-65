# frozen_string_literal: true

module Web
  class ProfileController < ApplicationController
    def show
      @q = current_user.bulletins.ransack(params[:q])
      @q.sorts = 'created_at desc'
      @bulletins = @q.result.page(params[:page])
    end
  end
end
