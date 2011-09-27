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

  config.user_objects = {
    :user => User
  }

  config.user_object_for_path = {
    "" => User
  }
end