module SimpleAuth
  module Common
    class SessionMethods

      def self.login_method_form(app, params)
        unless app.logged_in?
          app.send :render, '/sessions/new'
        else
          app.send redirect_method, '/'
        end
      end

      def self.login_method(app, params)
        user = SimpleAuth::Config.model_object.call.authenticate(
          params[SimpleAuth::Config.login_field.call],
          params[SimpleAuth::Config.password_field.call]
        )

        if user
          if user.active?
            app.current_user = user
            app.flash[:notice] = SimpleAuth::Config.authenticated_message.call
            app.send redirect_method, (params[:redirect_path] || '/')
          else
            app.flash.now[:alert] = SimpleAuth::Config.registration_unconfirmed_message.call
            app.send :render, '/sessions/new'
          end
        else
          app.flash.now[:alert] = SimpleAuth::Config.unauthenticated_message.call
          app.send :render, '/sessions/new'
        end
      end

      def self.logout_method(app, params)
        if app.logged_in?
          app.log_out!
          app.flash[:notice] = SimpleAuth::Config.logged_out_message.call
        end
        app.send redirect_method, '/sessions/new'
      end

    private

      def self.redirect_method
        defined?(::Rails) ? :redirect_to : :redirect
      end

    end

  end
end
