SimpleAuth::Config.setup do |config|

  # User controller stuff
  config.registration_successful_message    = Proc.new { "" }
  config.registration_unsuccessful_message  = Proc.new { "" }
  config.update_successful_message          = Proc.new { "" }
  config.update_unsuccessful_message        = Proc.new { "" }
  config.registration_confirmed_message     = Proc.new { "" }
  config.registration_not_confirmed_message = Proc.new { "" }


  # Session Controller stuff
  config.unauthenticated_message            = Proc.new { "" }
  config.logged_in_message                  = Proc.new { "" }
  config.logged_out_message                 = Proc.new { "" }
  config.login_field                        = Proc.new { "" }
  config.password_field                     = Proc.new { "" }

  config.user_object                        = Proc.new { nil }

  # Redirects and renders

  config.index_user_path                    = Proc.new { '/users' }
  config.new_user_path                      = Proc.new { '/users/new' }
  config.create_user_path                   = Proc.new { '/users' }
  config.edit_user_path                     = Proc.new { '/users/:id/edit' }
  config.update_user_path                   = Proc.new { '/users/:id' }
  config.show_user_path                     = Proc.new { '/users/:id' }
  config.destroy_user_path                  = Proc.new { '/users/:id' }

  config.confirmation_user_path             = Proc.new { '/users/confirm/:confirmation_code' }
  config.confirmation_resend_user_path      = Proc.new { '/users/confirmation_resend' }

  config.forgot_password_user_path          = Proc.new { '/users/forgot_password' }
end
