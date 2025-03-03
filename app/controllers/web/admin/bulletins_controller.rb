# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      before_action :authorize_action
      before_action :set_bulletin, only: %i[archive publish reject]

      def index
        if params[:state] == 'under_moderation'
          @bulletins = Bulletin.under_moderation.page(params[:page])

          render :under_moderation
        else
          @q = Bulletin.order(created_at: :desc).ransack(params[:q])
          @bulletins = @q.result.page(params[:page])

          render :index
        end
      end

      def under_moderation
        @bulletins = Bulletin.under_moderation.page(params[:page])
      end

      def archive
        if @bulletin.may_archive? && @bulletin.archive!
          redirect_to admin_path, notice: t('.success')
        else
          redirect_to admin_path, alert: t('.failure')
        end
      end

      def publish
        if @bulletin.may_publish? && @bulletin.publish!
          redirect_to admin_path, notice: t('.success')
        else
          redirect_to admin_path, alert: t('.failure')
        end
      end

      def reject
        if @bulletin.may_reject? && @bulletin.reject!
          redirect_to admin_path, notice: t('.success')
        else
          redirect_to admin_path, alert: t('.failure')
        end
      end

      private

      def authorize_action
        authorize(%i[admin bulletin])
      end

      def set_bulletin
        @bulletin = Bulletin.find(params[:id])
      end
    end
  end
end
