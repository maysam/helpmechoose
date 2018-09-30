class LoginsController < ApplicationController
  def new
  end

  def create
    if user = authenticate_with_google
      cookies.signed[:user_id] = user.id
      redirect_to user
    else
      redirect_to new_session_url, alert: 'authentication_failed'
    end
  end

  private
    def authenticate_with_google
      if flash[:google_sign_in_token].present?
        iden = GoogleSignIn::Identity.new flash[:google_sign_in_token]
        Rails.logger.error flash[:google_sign_in_token]
        Rails.logger.error iden
        user = User.find_by_google_id iden.user_id
        unless user
          user = User.create google_id: iden.user_id
        end
        user
      end
    end
end
