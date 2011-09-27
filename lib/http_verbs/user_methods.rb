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
          # need to see what in sinatra can identify this route
          @user = user_class('something').new
          render '/users/new'
        end

        # Create
        app.post '/users/?' do
          @user = user_class('something').new params[:user]

          if @user.save
            flash[:notice] = SimpleAuth::Config.registration_successful_message
            redirect '/'
          else
            flash[:error] = SimpleAuth::Config.registration_unsuccessful_message
            render '/users/new'
          end
        end

        # Edit
        app.get '/users/edit/:id' do
          @user = user_class('something').find(params[:id])
          render '/users/edit'
        end

        # Update
        app.put '/users/?' do
          @user = SimpleAuth::Config.user

          if @user.save
            flash[:notice] = SimpleAuth::Config.update_successful_message
            redirect '/'
          else
            flash[:error] = SimpleAuth::Config.update_unsuccessful_message
            render '/users/new'
          end
        end

        # Confirm
        app.get '/users/confirm/:confirm_code' do
          if user_class('something').activate params[:confirm_code]
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
