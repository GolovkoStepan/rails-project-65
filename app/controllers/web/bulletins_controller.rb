# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    before_action :set_bulletin, only: %i[show edit update to_moderate archive]

    def index
      @categories = Category.all
      @q = Bulletin.published.order(created_at: :desc).ransack(params[:q])
      @bulletins = @q.result.page(params[:page])
    end

    def show; end

    def new
      @bulletin = Bulletin.new
      authorize(@bulletin)
    end

    def edit
      authorize(@bulletin)
    end

    def create
      @bulletin = Bulletin.new(bulletin_params.merge(user: current_user))
      authorize(@bulletin)

      if @bulletin.save
        redirect_to @bulletin, notice: t('.success')
      else
        flash.now[:alert] = t('.failure')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      authorize(@bulletin)

      if @bulletin.update(bulletin_params)
        redirect_to @bulletin, notice: t('.success')
      else
        flash.now[:alert] = t('.failure')
        render :edit, status: :unprocessable_entity
      end
    end

    def to_moderate
      authorize(@bulletin)

      if @bulletin.to_moderate!
        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, alert: t('.failure')
      end
    end

    def archive
      authorize(@bulletin)

      if @bulletin.archive!
        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, alert: t('.failure')
      end
    end

    private

    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end
  end
end
