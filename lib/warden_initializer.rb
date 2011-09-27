module WardenInitializer
  def self.registered(app)
    # Make the methods in the helpers module available to all controllers
    app.helpers ::WardenInitializer::Helpers

    app.use Warden::Manager do |config|
      # Allows user to set a method that will return the path
      # the app will redirect to in case of failure
      # Otherwise it will use the default path of /sessions/unauthenticated
      auth_path = try(:unauthenticated_path)
      auth_path = "/sessions/unauthenticated" if auth_path.nil?

      config.default_scope = :default
      config.scope_defaults :default, {
        :strategies => [:password],
        :action     => auth_path
      }

      # I think we don't need a failure app
      #config.failure_app = app
    end

    Warden::Manager.before_failure do |env,opts|
      # Sinatra is very sensitive to the request method
      # since authentication could fail on any type of method, we need
      # to set it for the failure app so it is routed to the correct block
      env['REQUEST_METHOD'] = "POST"
    end

    Warden::Manager.serialize_into_session{|user| user.id }
    Warden::Manager.serialize_from_session{|id| User.get(id) }

    Warden::Strategies.add(:password) do
      def username
        params['email'] || params['login']
      end

      def valid?
        username && params["password"]
      end

      def authenticate!
        u = User.authenticate(username, params["password"])
        u.nil? ? fail!("Not logged in") : success!(u)
      end
    end
  end
end

