module SimpleAuth
  module HTTPVerbs
    module UserMethods
      def self.registered(app)
        # We'll even do the user registration methods for you as well

        # Index
        map_route = SimpleAuth::Config.index_user_path.call
        paramz = defined?(Padrino) ? [:index, {:map => map_route, :priority => :low}] : [map_route]
        app.get(*paramz) { SimpleAuth::Common::UserMethods.method_index(self, params) }

        # New
        map_route = SimpleAuth::Config.new_user_path.call
        paramz = defined?(Padrino) ? [:new, {:map => map_route, :priority => :low}] : [map_route]
        app.get(*paramz) { SimpleAuth::Common::UserMethods.method_new(self, params) }

        # Create
        map_route = SimpleAuth::Config.create_user_path.call
        paramz = defined?(Padrino) ? [:create, {:map => map_route, :priority => :low}] : [map_route]
        app.post(*paramz) { SimpleAuth::Common::UserMethods.method_create(self, params) }

        # Edit
        map_route = SimpleAuth::Config.edit_user_path.call
        paramz = defined?(Padrino) ? [:edit, {:map => map_route, :priority => :low}] : [map_route]
        app.get(*paramz) { SimpleAuth::Common::UserMethods.method_edit(self, params) }

        # Update
        map_route = SimpleAuth::Config.edit_user_path.call
        paramz = defined?(Padrino) ? [:update, {:map => map_route, :priority => :low}] : [map_route]
        app.put(*paramz) { SimpleAuth::Common::UserMethods.method_update(self, params) }

        # Delete
        map_route = SimpleAuth::Config.update_user_path.call
        paramz = defined?(Padrino) ? [:delete, {:map => map_route, :priority => :low}] : [map_route]
        app.delete(*paramz) { SimpleAuth::Common::UserMethods.method_delete(self, params) }

        # Confirm
        map_route = SimpleAuth::Config.confirmation_user_path.call
        paramz = defined?(Padrino) ? [:confirmation_code, {:map => map_route, :priority => :low}] : [map_route]
        app.get(*paramz) { SimpleAuth::Common::UserMethods.method_confirm(self, params) }

        # Confirm resend form
        map_route = SimpleAuth::Config.confirmation_resend_user_path.call
        paramz = defined?(Padrino) ? [:confirmation_resend, {:map => map_route, :priority => :low}] : [map_route]
        app.get(*paramz) { SimpleAuth::Common::UserMethods.method_confirm_resend_form(self, params) }

        # Confirm resend submit
        map_route = SimpleAuth::Config.confirmation_resend_user_path.call
        paramz = defined?(Padrino) ? [:confirmation_resend, {:map => map_route, :priority => :low}] : [map_route]
        app.put(*paramz) { SimpleAuth::Common::UserMethods.method_confirm_resend(self, params) }

        # Forgot password form
        map_route = SimpleAuth::Config.forgot_password_user_path.call
        paramz = defined?(Padrino) ? [:forgot_password, {:map => map_route, :priority => :low}] : [map_route]
        app.get(*paramz) { SimpleAuth::Common::UserMethods.method_forgot_password_form(self, params) }

        # Forgot password submit
        map_route = SimpleAuth::Config.forgot_password_user_path.call
        paramz = defined?(Padrino) ? [:forgot_password, {:map => map_route, :priority => :low}] : [map_route]
        app.put(*paramz) { SimpleAuth::Common::UserMethods.method_forgot_password(self, params) }

      end
    end
  end
end
