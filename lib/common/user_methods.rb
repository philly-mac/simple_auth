module SimpleAuth
  module Common
    module UserMethods

      class << self

        def method_index(app, params)
          app.render '/'
        end

        def method_new(app, params)
          @user = SimpleAuth::Config.user_object.new
          app.render '/users/new'
        end

        def method_create(app, params)
          @user = SimpleAuth::Config.user_object.new params[:user]

          if @user.save
            flash[:notice] = SimpleAuth::Config.registration_successful_message
            send redirect_method, '/'
          else
            flash[:error] = SimpleAuth::Config.registration_unsuccessful_message
            app.render '/users/new'
          end
        end

        def method_edit(app, params)
          @user = SimpleAuth::Config.user_object.first(params[:id])
          app.render '/users/edit'
        end

        def method_update(app, params)
          @user = SimpleAuth::Config.user

          if @user.save
            flash[:notice] = SimpleAuth::Config.update_successful_message
            app.send redirect_method, '/'
          else
            flash[:error] = SimpleAuth::Config.update_unsuccessful_message
            app.render '/users/new'
          end
        end

        def method_delete(app, params)
          @user = SimpleAuth::Config.user.first params[:id]
          @user.destroy if @user
          send redirect_method, '/'
        end

        def method_confirm(app, params)
          if SimpleAuth::Config.user_object.activate params[:confirmation_code]
            flash[:notice] = SimpleAuth::Config.registration_confirmed_message
            app.send redirect_method, '/'
          else
            flash[:alert] = SimpleAuth::Config.registration_not_confirmed_message
            app.send redirect_method, '/'
          end
        end

        def method_confirm_resend_form(app, params)
          app.render '/users/confirmation_resend'
        end

        def method_confirm_resend(app, params)
          if user = SimpleAuth::Config.user_object.first(:email => params[:email])
            deliver(:user, :confirmation_email, user, confirmation_link(user))
          end
          app.redirect '/'
        end

        def method_forgot_password_form(app, params)
          app.render '/users/forgot_password'
        end

        def method_forgot_password(app, params)
          if user = SimpleAuth::Config.user_object.first(:email => params[:email])
            deliver(:user, :confirmation_email, user, confirmation_link(user))
          end
          app.redirect '/'
        end

      private

        def redirect_method
          defined?(::Rails) ? :redirect_to : :redirect
        end

      end

    end
  end
end
