module WardenInitializer
  def self.registered(app)
    # Make the methods in the helpers module available to all controllers
    app.helpers ::WardenInitializer::Helpers

    Warden::Manager.serialize_into_session{|user| user.id }
    Warden::Manager.serialize_from_session{|id| User.get(id) }

    Warden::Manager.before_failure do |env,opts|
      # Sinatra is very sensitive to the request method
      # since authentication could fail on any type of method, we need
      # to set it for the failure app so it is routed to the correct block
      env['REQUEST_METHOD'] = "POST"
    end

    Warden::Strategies.add(:basic) do
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

    Warden::Strategies.add(:password) do
      def valid?
        params["email"] || params["password"]
      end

      def authenticate!
        u = User.authenticate(params["email"], params["password"])
        u.nil? ? fail!("Could not log in") : success!(u)
      end
    end

    Warden::Manager.serialize_into_session do |user|
      user.id
    end

    Warden::Manager.serialize_from_session do |id|
      User.get(id)
    end

    app.use Warden::Manager do |config|
      auth_path = app.url_for(:sessions, :unauthenticated).sub("/",'')
      auth_path = auth_path.sub("/",'') if auth_path[0,1] == '/'

      config.default_scope = :default
      config.scope_defaults :default,
        :strategies => [:basic],
        :action => auth_path
      config.failure_app = app
    end
  end

  module Helpers
    def warden
      env['warden']
    end

    # Proxy to the authenticated? method on warden
    def authenticated?(*args)
      warden.authenticated?(*args)
    end
    alias_method :logged_in?, :authenticated?

    # Access the currently logged in user
    def user(*args)
      warden.user(*args)
    end
    alias_method :current_user, :user

    # Set the currently logged in user
    # Usage: self.user = @user
    #
    # @param [User] the user you want to log in
    def user=(new_user)
      warden.set_user(new_user)
    end
    alias_method :current_user=, :user=

  end
end
