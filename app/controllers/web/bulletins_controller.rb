# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    def index
      @q = policy_scope(Bulletin).ransack(params[:q])
      @q.sorts = 'created_at desc'
      @bulletins = @q.result.page(params[:page])
      @categories = Category.order(name: :asc)
    end

    def show
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
    end

    def new
      @bulletin = Bulletin.new
      authorize @bulletin
    end

    def edit
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
    end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)
      authorize @bulletin

      if @bulletin.save
        redirect_to @bulletin, notice: t('.success')
      else
        flash.now[:alert] = t('.failure')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin

      if @bulletin.update(bulletin_params)
        redirect_to @bulletin, notice: t('.success')
      else
        flash.now[:alert] = t('.failure')
        render :edit, status: :unprocessable_entity
      end
    end

    def to_moderate
      @bulletin = Bulletin.find(params[:id])

      if @bulletin.to_moderate!
        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, notice: t('.failure')
      end
    end

    def archive
      @bulletin = Bulletin.find(params[:id])

      if @bulletin.archive!
        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, notice: t('.failure')
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end
  end
end
