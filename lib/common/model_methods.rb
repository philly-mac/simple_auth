module SimpleAuth
  module Common
    class ModelMethods

      def self.method_index(app, params)
        app.send :render, '/'
      end

      def self.method_new(app, params)
        @user = SimpleAuth::Config.model_object.call.new
        app.send :render, '/users/new'
      end

      def self.method_create(app, params)
        @user = SimpleAuth::Config.model_object.call.new params[:user]

        if @user.save
          app.flash[:notice] = SimpleAuth::Config.registration_successful_message
          send redirect_method, '/'
        else
          flash[:error] = SimpleAuth::Config.registration_unsuccessful_message
          app.send :render, '/users/new'
        end
      end

      def self.method_edit(app, params)
        @user = SimpleAuth::Config.model_object.call.first(params[:id])
        app.send :render, '/users/edit'
      end

      def self.method_update(app, params)
        @user = SimpleAuth::Config.model_object.call

        if @user.save
          app.flash[:notice] = SimpleAuth::Config.update_successful_message.call
          app.send redirect_method, '/'
        else
          app.flash[:error] = SimpleAuth::Config.update_unsuccessful_message.call
          app.send :render, '/users/new'
        end
      end

      def self.method_delete(app, params)
        @user = SimpleAuth::Config.model_object.call.first params[:id]
        @user.destroy if @user
        app.send redirect_method, '/'
      end

      def self.method_confirm(app, params)
        if user = SimpleAuth::Config.model_object.call.activate!(params[:confirmation_code])
          app.current_user = user
          app.flash[:notice] = SimpleAuth::Config.registration_confirmed_message.call
          app.send redirect_method, '/'
        else
          app.flash[:alert] = SimpleAuth::Config.registration_not_confirmed_message.call
          app.send redirect_method, '/'
        end
      end

      def self.method_confirm_resend_form(app, params)
        app.send :render, '/users/confirmation_resend'
      end

      def self.method_confirm_resend(app, params)
        if user = SimpleAuth::Config.model_object.call.first(SimpleAuth::Util.to_params({:email => params[:email]}))
          unless user.active?
            app.flash[:notice] = "registration.confirmation_resent_message".t
            if defined?(::Rails)
              SimpleAuth::Config.confirmation_email_notification.call(user)
            else
              app.deliver(:user, :confirmation_email, user)
            end
          else
            app.flash[:alert] = "registration.already_confirmed_message".t
          end
          app.send redirect_method, '/'
        else
          app.flash.now[:alert] = "registration.not_confirmed_message".t
          app.send :render, '/users/confirmation_resend'
        end
      end

      def self.method_forgot_password_form(app, params)
        app.send :render, '/users/forgot_password'
      end

      def self.method_forgot_password(app, params)
        if user = SimpleAuth::Config.model_object.call.first(SimpleAuth::Util.to_params({:email => params[:email]}))
          password = SimpleAuth::Config.model_object.call.random_alphanumeric(12)
          user.password = password
          user.password_confirmation = password
          user.save
          app.flash[:notice] = "registration.password_reset".t
          SimpleAuth::Config.password_reset_notification.call(user)
          app.send redirect_method, '/'
        else
          app.flash.now[:alert] = "registration.password_not_reset".t
          app.send :render, '/users/forgot_password'
        end
      end

    private

      def self.redirect_method
        defined?(::Rails) ? :redirect_to : :redirect
      end

    end

  end
end
