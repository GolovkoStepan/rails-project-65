# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      def index
        @q = Bulletin.ransack(params[:q])
        @q.sorts = 'created_at desc'
        @bulletins = @q.result.page(params[:page])
      end

      def under_moderation
        @bulletins = Bulletin.under_moderation.page(params[:page])
      end

      def archive
        @bulletin = Bulletin.find(params[:id])

        if @bulletin.archive!
          redirect_to admin_path, notice: t('.success')
        else
          redirect_to admin_path, notice: t('.failure')
        end
      end

      def publish
        @bulletin = Bulletin.find(params[:id])

        if @bulletin.publish!
          redirect_to admin_path, notice: t('.success')
        else
          redirect_to admin_path, notice: t('.failure')
        end
      end

      def reject
        @bulletin = Bulletin.find(params[:id])

        if @bulletin.reject!
          redirect_to admin_path, notice: t('.success')
        else
          redirect_to admin_path, notice: t('.failure')
        end
      end
    end
  end
end
