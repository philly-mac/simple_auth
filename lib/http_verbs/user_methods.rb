module SimpleAuth
  module HTTPVerbs
    module UserMethods
      def self.registered(app)
        # We'll even do the user registration methods for you as well

        params = defined?(Padrino) ? [:index, :map => '/users'] : ['/users']

        # Index
        app.get(*params) do
          render '/'
        end

        params = defined?(Padrino) ? [:new, {:map => '/users/new', :priority => :low}] : ['/users/new']

        # New
        app.get(*params) do
          @user = SimpleAuth::Config.user_object.new
          render '/users/new'
        end

        params = defined?(Padrino) ? [:create, {:map => '/users', :priority => :low}] : ['/users']

        # Create
        app.post(*params) do
          @user = user_class('something').new params[:user]

          if @user.save
            flash[:notice] = SimpleAuth::Config.registration_successful_message
            redirect '/'
          else
            flash[:error] = SimpleAuth::Config.registration_unsuccessful_message
            render '/users/new'
          end
        end

        params = defined?(Padrino) ? [:edit, {:map => '/users/:id/edit', :priority => :low}] : ['/users/:id/edit']

        # Edit
        app.get(*params) do
          @user = user_class('something').find(params[:id])
          render '/users/edit'
        end

        params = defined?(Padrino) ? [:update, {:map => '/users/:id', :priority => :low}] : ['/users/:id']

        # Update
        app.put(*params) do
          @user = SimpleAuth::Config.user

          if @user.save
            flash[:notice] = SimpleAuth::Config.update_successful_message
            redirect '/'
          else
            flash[:error] = SimpleAuth::Config.update_unsuccessful_message
            render '/users/new'
          end
        end

        params = defined?(Padrino) ? [:delete, {:map => '/users/:id', :priority => :low}] : ['/users/:id']

        app.delete(*params) do

        end

        params = defined?(Padrino) ? [:confirm, {:map => '/users/confirm/:confirm_code', :priority => :low}] : ['/users/confirm/:confirm_code']

        # Confirm
        app.get(*params) do
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
