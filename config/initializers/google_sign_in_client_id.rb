# GoogleSignIn::Identity.client_id = '548879979522-1de7d3ub4pc131eues5h6iapgmm1c42a.apps.googleusercontent.com' if Rails.env.development?

# GoogleSignIn::Identity.client_id = '548879979522-jst5hc5q334h96navh3g74gq3mdsocu1.apps.googleusercontent.com' if Rails.env.production?

Rails.application.configure do
  config.google_sign_in.client_id     = '548879979522-1de7d3ub4pc131eues5h6iapgmm1c42a.apps.googleusercontent.com' if Rails.env.development?

  config.google_sign_in.client_id     = '548879979522-jst5hc5q334h96navh3g74gq3mdsocu1.apps.googleusercontent.com' if Rails.env.production?
  config.google_sign_in.client_secret = 'P7o8mU7j_8JSMeGJcDt9yqJS' if Rails.env.development?
  config.google_sign_in.client_secret = 'GXZuz-2WJaArEzK71OwI4-KH' if Rails.env.production?
end

# {"web":{"client_id":"548879979522-1de7d3ub4pc131eues5h6iapgmm1c42a.apps.googleusercontent.com","project_id":"code-hospital","auth_uri":"https://accounts.google.com/o/oauth2/auth","token_uri":"https://www.googleapis.com/oauth2/v3/token","auth_provider_x509_cert_url":"https://www.googleapis.com/oauth2/v1/certs","client_secret":"P7o8mU7j_8JSMeGJcDt9yqJS","redirect_uris":["http://maysam.dlinkddns.com/google_sign_in/callback"],"javascript_origins":["http://maysam.dlinkddns.com"]}}



# {"web":{"client_id":"548879979522-jst5hc5q334h96navh3g74gq3mdsocu1.apps.googleusercontent.com","project_id":"code-hospital","auth_uri":"https://accounts.google.com/o/oauth2/auth","token_uri":"https://www.googleapis.com/oauth2/v3/token","auth_provider_x509_cert_url":"https://www.googleapis.com/oauth2/v1/certs","client_secret":"GXZuz-2WJaArEzK71OwI4-KH","javascript_origins":["https://pleasehelpmechoose.herokuapp.com"]}}
