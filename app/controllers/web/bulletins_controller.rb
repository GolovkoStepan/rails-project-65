module Web
  class BulletinsController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index]

    def index
      @bulletins = Bulletin.all
    end

    def show
      @bulletin = Bulletin.find(params[:id])
    end

    def new
      @bulletin = Bulletin.new
    end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)

      if @bulletin.save
        redirect_to @bulletin, notice: 'Успешно'
      else
        flash.now[:alert] = 'Ошибка при создании'
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @bulletin = Bulletin.find(params[:id])
    end

    def update
      @bulletin = Bulletin.find(params[:id])

      if @bulletin.update(bulletin_params)
        redirect_to @bulletin, notice: 'Успешно'
      else
        flash.now[:alert] = 'Ошибка при редактировании'
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end
  end
end
