class LoginsController < ApplicationController
  def new
  end

  def create
    user = authenticate_with_google
    if user.id
      cookies.signed[:user_id] = user.id
      redirect_to user
    else
      redirect_to sessions_url, alert: user.name
    end
  end

  private
    def authenticate_with_google
      if flash[:google_sign_in_token].present?
        iden = GoogleSignIn::Identity.new flash[:google_sign_in_token]
        Rails.logger.info iden
        Rails.logger.info iden.as_json
        user = User.find_or_create_by google_id: iden.user_id
        user.update_attributes locale: iden.locale, name: iden.name, email: iden.email_address, picture: iden.avatar_url, email_verified: iden.email_verified?
        # given_name: payload['given_name'], family_name: payload['family_name']
        user
      end
    rescue StandardError => e
      Rails.logger.error e
      #   User.first
      User.new name: e.message
    end
end
