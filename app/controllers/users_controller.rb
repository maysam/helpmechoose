require 'open-uri'

class UsersController < ApplicationController
  def show
    @user = User.find cookies.signed[:user_id]
  end

  def signout
    cookies.signed[:user_id] = nil
    redirect_to new_session_url
  end

  def auth
    url = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{params[:id_token]}"
    data = open url
    iden = JSON.parse data.string
    iden.symbolize_keys!
    user = User.find_or_create_by google_id: iden[:sub]
    user.update_attributes locale: iden[:locale], name: iden[:name], email: iden[:email], picture: iden[:picture], given_name: iden[:given_name], family_name: iden[:family_name], email_verified: iden[:email_verified]
    cookies.signed[:user_id] = user.id
    redirect_to user
  rescue StandardError => e
    Rails.logger.error e
    redirect_to new_session_url, alert: e.message
  end
  # {
  #   "iss": "accounts.google.com",
  #   "azp": "548879979522-pfjjpteqqm1r21rirnfqbk65eufh3pdh.apps.googleusercontent.com",
  #   "aud": "548879979522-pfjjpteqqm1r21rirnfqbk65eufh3pdh.apps.googleusercontent.com",
  #   "sub": "117146315519293105694",
  #   "email": "kherad@gmail.com",
  #   "email_verified": "true",
  #   "at_hash": "GK0IvHRXsB0wXW0ELhAeEw",
  #   "name": "Maysam Torabi",
  #   "picture": "https://lh5.googleusercontent.com/-1vUCpHtU_8k/AAAAAAAAAAI/AAAAAAAGuwo/xeZuwvmXM_Y/s96-c/photo.jpg",
  #   "given_name": "Maysam",
  #   "family_name": "Torabi",
  #   "locale": "en-GB",
  #   "iat": "1542199097",
  #   "exp": "1542202697",
  #   "jti": "76e7d717f56dd8289d90d1e952ab1c4bbec38227",
  #   "alg": "RS256",
  #   "kid": "d1e869e7bf40ddc3d3de08042598ba8350970f0a",
  #   "typ": "JWT"
  # }
  def index
  end
end
