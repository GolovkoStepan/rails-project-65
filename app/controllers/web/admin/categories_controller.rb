# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < ApplicationController
      before_action :authorize_action
      before_action :set_category, only: %i[edit update destroy]

      def index
        @categories = Category.page(params[:page])
      end

      def new
        @category = Category.new
      end

      def edit; end

      def create
        @category = Category.new(category_params)

        if @category.save
          redirect_to admin_categories_path, notice: t('.success')
        else
          render :new, status: :unprocessable_entity
        end
      end

      def update
        if @category.update(category_params)
          redirect_to admin_categories_path, notice: t('.success')
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        if @category.destroy
          redirect_to admin_categories_path, notice: t('.success')
        else
          redirect_to admin_categories_path, alert: @category.errors.full_messages.to_sentence
        end
      end

      private

      def authorize_action
        authorize(%i[admin category])
      end

      def category_params
        params.require(:category).permit(:name)
      end

      def set_category
        @category = Category.find(params[:id])
      end
    end
  end
end
