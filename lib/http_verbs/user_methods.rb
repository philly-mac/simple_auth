module SimpleAuth
  module HTTPVerbs
    module UserMethods
      def self.registered(app)
        # We'll even do the user registration methods for you as well

        # Index
        map_route = SimpleAuth::Config.index_user_path
        paramz = defined?(Padrino) ? [:index, {:map => map_route, :priority => :low}] : [map_route]

        app.get(*paramz) do
          SimpleAuth::Common::UserMethods.method_index(self, params)
        end

        # New
        map_route = SimpleAuth::Config.new_user_path
        paramz = defined?(Padrino) ? [:new, {:map => map_route, :priority => :low}] : [map_route]

        app.get(*paramz) do
          SimpleAuth::Common::UserMethods.method_new(self, params)
        end

        # Create
        map_route = SimpleAuth::Config.create_user_path
        paramz = defined?(Padrino) ? [:create, {:map => map_route, :priority => :low}] : [map_route]

        app.post(*paramz) do
          SimpleAuth::Common::UserMethods.method_create(self, params)
        end

        # Edit
        map_route = SimpleAuth::Config.edit_user_path
        paramz = defined?(Padrino) ? [:edit, {:map => map_route, :priority => :low}] : [map_route]

        app.get(*paramz) do
          SimpleAuth::Common::UserMethods.method_edit(self, params)
        end

        # Update
        map_route = SimpleAuth::Config.edit_user_path
        paramz = defined?(Padrino) ? [:update, {:map => map_route, :priority => :low}] : [map_route]

        app.put(*paramz) do
          SimpleAuth::Common::UserMethods.method_update(self, params)
        end

        map_route = SimpleAuth::Config.update_user_path
        paramz = defined?(Padrino) ? [:delete, {:map => map_route, :priority => :low}] : [map_route]

        app.delete(*paramz) do
          SimpleAuth::Common::UserMethods.method_delete(self, params)
        end

        # Confirm
        map_route = SimpleAuth::Config.confirmation_user_path
        paramz = defined?(Padrino) ? [:confirmation_code, {:map => map_route, :priority => :low}] : [map_route]

        app.get(*paramz) do
          SimpleAuth::Common::UserMethods.method_confirm(self, params)
        end

        # Confirm resend form
        map_route = SimpleAuth::Config.confirmation_resend_user_path
        paramz = defined?(Padrino) ? [:confirmation_resend, {:map => map_route, :priority => :low}] : [map_route]

        app.get(*paramz) do
          SimpleAuth::Common::UserMethods.method_confirm_resend_form(self, params)
        end

        # Confirm resend submit
        map_route = SimpleAuth::Config.confirmation_resend_user_path
        paramz = defined?(Padrino) ? [:confirmation_resend, {:map => map_route, :priority => :low}] : [map_route]

        app.put(*paramz) do
          SimpleAuth::Common::UserMethods.method_confirm_resend(self, params)
        end

        # Forgot password form
        map_route = SimpleAuth::Config.forgot_password_user_path
        paramz = defined?(Padrino) ? [:forgot_password, {:map => map_route, :priority => :low}] : [map_route]

        app.get(*paramz) do
          SimpleAuth::Common::UserMethods.method_forgot_password_form(self, params)
        end

        # Forgot password submit
        map_route = SimpleAuth::Config.forgot_password_user_path
        paramz = defined?(Padrino) ? [:forgot_password, {:map => map_route, :priority => :low}] : [map_route]

        app.put(*paramz) do
          SimpleAuth::Common::UserMethods.method_forgot_password(self, params)
        end

      end
    end
  end
end
