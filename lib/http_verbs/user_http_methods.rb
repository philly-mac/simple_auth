module SimpleAuth
  module HTTPVerbs
    module UserMethods
      def self.registered(app)
        # We'll even do the user registration methods for you as well

        # Index
        app.get '/users/?' do
          render '/'
        end

        # New
        app.get '/users/new/?' do
          @user = User.new
          render '/users/new'
        end

        # Create
        app.post '/users/?' do
          @user = User.new params[:user]

          if @user.save
            flash[:notice] = warden_auth_options[:registration_successful_message]
            redirect '/'
          else
            flash[:error] = warden_auth_options[:registration_unsuccessful_message]
            render '/users/new'
          end
        end

        # Edit
        app.get '/users/edit/?' do
          @user = user_clazz.new
          render '/users/edit'
        end

        # Update
        app.put '/users/?' do
          @user = User.new params[:user]

          if @user.save
            flash[:notice] = warden_auth_options[:update_successful_message]
            redirect '/'
          else
            flash[:error] = warden_auth_options[:update_unsuccessful_message]
            render '/users/new'
          end
        end

        # Confirm
        app.get '/users/confirm/:confirm_code' do
          if User.activate params[:confirm_code]
            flash[:notice] = warden_auth_options[:registration_confirmed_message]
            redirect '/'
          else
            flash[:error] = warden_auth_options[:registration_not_confirmed_message]
            redirect '/'
          end
        end
      end
    end
  end
end
