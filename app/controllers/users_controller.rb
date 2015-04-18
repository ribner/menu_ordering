class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, except: [:create, :new, :update, :index, :edit]

  private

  def authorize_user
    unless current_user.admin? || current_user == User.find(params[:id])
      not_found
    end
  end

  def authorize_admin
    unless current_user.admin?
      not_found
    end
  end

  def user_params
    params.require(:user).permit(:email, :admin, :name)
  end
end
end
