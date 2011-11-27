module SimpleAuth
  module HTTPVerbs
    class Utils

      class << self

        def logout_method(app, http_method, params)
          app.send(http_method, *params) do
            if logged_in?
              log_out!
              flash[:notice] = SimpleAuth::Config.logged_out_message
            end
            redirect '/sessions/new'
          end
        end

        def login_method(app, http_method, params)
          app.send(http_method, *params) do
            unless logged_in?
              render '/sessions/new'
            else
              redirect '/'
            end
          end
        end
      end
    end

    module AccessMethods
      def self.registered(app)
        paramz = (defined?(Padrino) ? [:logout, :map => '/logout'] : ['/logout/?'])
        ::SimpleAuth::HTTPVerbs::Utils.logout_method(app, :get, paramz)

        paramz = (defined?(Padrino) ? [:login, :map => '/login'] : ['/login/?'])
        ::SimpleAuth::HTTPVerbs::Utils.login_method(app, :get, paramz)
      end

    end

    module SessionMethods
      def self.registered(app)
        # And now, just because we are nice we are going to
        # set up all the session routes for you

        paramz = defined?(Padrino) ? [:new, :map => '/sessions/new'] : ['/sessions/new']

        ::SimpleAuth::HTTPVerbs::Utils.login_method(app, :get, paramz)

        paramz = defined?(Padrino) ? [:index, :map => '/sessions'] : ['/sessions/?']

        ::SimpleAuth::HTTPVerbs::Utils.login_method(app, :get, paramz)

        paramz = defined?(Padrino) ? [:create, :map => '/sessions'] : ['/sessions/?']

        app.post(*paramz) do
          user = SimpleAuth::Config.user_object.authenticate(
            params[SimpleAuth::Config.login_field],
            params[SimpleAuth::Config.password_field]
          )

          if user
            if user.active?
              self.current_user = user
              flash[:notice] = SimpleAuth::Config.authenticated_message
              redirect params[:redirect_path] || '/'
              return
            else
              flash.now[:alert] = SimpleAuth::Config.registration_unconfirmed_message
              render '/sessions/new'
            end
          else
            flash.now[:alert] = SimpleAuth::Config.unauthenticated_message
            render '/sessions/new'
          end

        end

        paramz = (defined?(Padrino) ? [:delete, :map => '/sessions'] : ['/sessions/?'])
        ::SimpleAuth::HTTPVerbs::Utils.logout_method(app, :delete, paramz)
      end
    end

  end
end

