module SimpleAuth
  module HTTPVerbs
    module SessionMethods
      def self.registered(app)
        # And now, just because we are nice we are going to
        # set up all the session routes for you

        app.get '/sessions/?' do
          redirect '/sessions/new'
        end

        app.post '/sessions/unauthenticated/?' do
          status 401
          warden.custom_failure!
          flash[:error] = warden_auth_options[:unauthenticated_message]
          render '/sessions/new'
        end

        app.get '/sessions/new/?' do
          render '/sessions/new'
        end

        app.post '/sessions/?' do
          warden.authenticate!
          flash[:notice] = warden_auth_options[:logged_in_message]
          redirect params[:redirect_path] || '/'
        end

        app.delete '/sessions/?' do
          if authenticated?(:default)
            warden.logout(:default)
            flash[:notice] = warden_auth_options[:logged_out_message]
          end
          redirect '/sessions/new'
        end
      end
    end
  end
end

