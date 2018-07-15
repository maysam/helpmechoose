class UsersController < ApplicationController
  def show
    @user = User.find cookies.signed[:user_id]
  end

  def index
  end
end
