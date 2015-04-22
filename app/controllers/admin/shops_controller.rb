module Admin
  class ShopsController < ApplicationController
    before_action :authorize_admin

    def show
      @shop = Shop.find(params[:id])
    end




    private

    def authorize_admin
      redirect_to new_user_session_path unless current_user.admin
    end

  end
end




