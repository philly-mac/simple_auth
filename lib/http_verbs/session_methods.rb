module SimpleAuth
  module HTTPVerbs

    module AccessMethods
      def self.registered(app)

        # Login
        map_route = '/login'
        paramz = (defined?(Padrino) ? [:login, {:map => map_route, :priority => :low}] : [map_route])
        app.get(*paramz) { SimpleAuth::Common::SessionMethods.login_method_form(self, params) }

        # Logout
        map_route = '/logout'
        paramz = (defined?(Padrino) ? [:logout, {:map => map_route, :priority => :low}] : [map_route])
        app.get(*paramz) { SimpleAuth::Common::SessionMethods.logout_method(self, params) }

      end

    end

    module SessionMethods
      def self.registered(app)

        # And now, just because we are nice we are going to
        # set up all the session routes for you

        # Index
        map_route = '/sessions'
        paramz = defined?(Padrino) ? [:index, {:map => map_route, :priority => :low}] : [map_route]
        app.get(*paramz) { SimpleAuth::Common::SessionMethods.login_method_form(self, params) }

        # New
        map_route = '/sessions/new'
        paramz = defined?(Padrino) ? [:new, {:map => map_route, :priority => :low}] : [map_route]
        app.get(*paramz) { SimpleAuth::Common::SessionMethods.login_method_form(self, params) }

        # Create
        map_route = '/sessions'
        paramz = defined?(Padrino) ? [:create, {:map => map_route, :priority => :low}] : [map_route]
        app.post(*paramz) { SimpleAuth::Common::SessionMethods.login_method(self, params) }

        # Delete
        map_route = '/sessions'
        paramz = defined?(Padrino) ? [:delete, {:map => map_route, :priority => :low}] : [map_route]
        app.delete(*paramz) { SimpleAuth::Common::SessionMethods.logout_method(self, params) }

      end
    end

  end
end

