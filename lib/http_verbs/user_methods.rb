module SimpleAuth
  module HTTPVerbs
    module UserMethods
      def self.registered(app)
        # We'll even do the user registration methods for you as well

        paramz = defined?(Padrino) ? [:index, :map => '/users'] : ['/users']

        # Index
        app.get(*paramz) do
          render '/'
        end

        paramz = defined?(Padrino) ? [:new, {:map => '/users/new', :priority => :low}] : ['/users/new']

        # New
        app.get(*paramz) do
          @user = SimpleAuth::Config.user_object.new
          render '/users/new'
        end

        paramz = defined?(Padrino) ? [:create, {:map => '/users', :priority => :low}] : ['/users']

        # Create
        app.post(*paramz) do
          @user = user_class('something').new params[:user]

          if @user.save
            flash[:notice] = SimpleAuth::Config.registration_successful_message
            redirect '/'
          else
            flash[:error] = SimpleAuth::Config.registration_unsuccessful_message
            render '/users/new'
          end
        end

        paramz = defined?(Padrino) ? [:edit, {:map => '/users/:id/edit', :priority => :low}] : ['/users/:id/edit']

        # Edit
        app.get(*paramz) do
          @user = user_class('something').find(params[:id])
          render '/users/edit'
        end

        paramz = defined?(Padrino) ? [:update, {:map => '/users/:id', :priority => :low}] : ['/users/:id']

        # Update
        app.put(*paramz) do
          @user = SimpleAuth::Config.user

          if @user.save
            flash[:notice] = SimpleAuth::Config.update_successful_message
            redirect '/'
          else
            flash[:error] = SimpleAuth::Config.update_unsuccessful_message
            render '/users/new'
          end
        end

        paramz = defined?(Padrino) ? [:delete, {:map => '/users/:id', :priority => :low}] : ['/users/:id']

        app.delete(*paramz) do

        end

        paramz = defined?(Padrino) ? [:confirm, {:map => '/users/confirm/:confirmation_code', :priority => :low}] : ['/users/confirm/:confirm_code']

        # Confirm
        app.get(*paramz) do
          if SimpleAuth::Config.user_object.activate params[:confirmation_code]
            flash[:notice] = SimpleAuth::Config.registration_confirmed_message
            redirect '/'
          else
            flash[:alert] = SimpleAuth::Config.registration_not_confirmed_message
            redirect '/'
          end

        end
      end
    end
  end
end
