class SessionsController < ApplicationController
  def new
  end

  def create
    if user = authenticate_via_google
      cookies.signed[:user_id] = user.id
      redirect_to user
    else
      redirect_to sessions_new_url, alert: "authentication_failed"
    end
  end

  def destroy
    cookies.signed[:user_id] = nil
    redirect_to sessions_new_url, alert: "logout_successfull"
  end

  private
    def authenticate_via_google
      if params[:google_id_token].present?
        iden = GoogleSignIn::Identity.new(params[:google_id_token])
        payload = iden.as_json['payload']
        user = User.find_or_create_by google_id: iden.user_id
        user.update_attributes locale: iden.locale, name: iden.name, email: iden.email_address, picture: iden.avatar_url, given_name: payload['given_name'], family_name: payload['family_name'], email_verified: payload['email_verified']
        user
      end
    end
end
