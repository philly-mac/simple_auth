module SimpleAuth
  module HTTPVerbs
    module SessionMethods
      def self.registered(app)
        # And now, just because we are nice we are going to
        # set up all the session routes for you

        app.get '/sessions/?' do
          redirect '/sessions/new'
        end

        app.get '/sessions/new/?' do
          render '/sessions/new'
        end

        app.post '/sessions/?' do
          user = SimpleAuth::Config.user_objects[params[:user_type]].authenticate(
            params[SimpleAuth::Config.login_field],
            parsms[SimpleAuth::Config.password_field]
          )

          if user
            current_user = user
            flash[:notice] = SimpleAuth::Config.logged_in_message
            redirect params[:redirect_path] || '/'
          else
            flash.now[:alert] = SimpleAuth::Config.unauthenticated_message
            render '/sessions/new'
          end

        end

        app.delete '/sessions/?' do
          if authenticated?(:default)
            warden.logout(:default)
            flash[:notice] = SimpleAuth::Config.logged_out_message
          end
          redirect '/sessions/new'
        end
      end
    end
  end
end

