SimpleAuth::Config.setup do |config|

  # User controller stuff
  config.registration_successful_message    = ""
  config.registration_unsuccessful_message  = ""
  config.update_successful_message          = ""
  config.update_unsuccessful_message        = ""
  config.registration_confirmed_message     = ""
  config.registration_not_confirmed_message = ""


  # Session Controller stuff
  config.unauthenticated_message = ""
  config.logged_in_message       = ""
  config.logged_out_message      = ""
  config.login_field             = ""
  config.password_field          = ""

  config.user_object             = nil

  # Redirects and renders

  config.index_user_path         = '/users'
  config.new_user_path           = '/users/new'
  config.create_user_path        = '/users'
  config.edit_user_path          = '/users/:id/edit'
  config.update_user_path        = '/users/:id'
  config.show_user_path          = '/users/:id'
  config.destroy_user_path       = '/users/:id'

  config.confirmation_user_path         = '/users/confirm/:confirmation_code'
  config.confirmation_resend_user_path  = '/users/confirmation_resend'

  config.forgot_password_user_path      = '/users/forgot_password'
end
