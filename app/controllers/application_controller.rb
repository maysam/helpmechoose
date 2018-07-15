class ApplicationController < ActionController::Base
  def index
    if cookies.signed[:user_id] && user = User.find_by(id: cookies.signed[:user_id])
      redirect_to user
    else
      redirect_to sessions_new_path
    end
  end
end
