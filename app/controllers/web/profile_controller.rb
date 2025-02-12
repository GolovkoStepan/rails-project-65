module Web
  class ProfileController < ApplicationController
    def show
      @bulletins = Bulletin.where(user: current_user)
    end
  end
end
