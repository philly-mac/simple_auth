module SimpleAuth
  module Methods
    module SessionMethods

      def index
        redirect_to '/sessions/new'
      end

      def new
        render '/sessions/new'
      end

      def create
        user = SimpleAuth::Config.user_object.authenticate(
          params[SimpleAuth::Config.login_field],
          params[SimpleAuth::Config.password_field]
        )

        if user
          if user.active?
            self.current_user = user
            redirect_to params[:redirect_path] || '/', :notice => SimpleAuth::Config.authenticated_message
            return
          else
            flash.now[:alert] = SimpleAuth::Config.registration_unconfirmed_message
          end
        else
          flash.now[:alert] = SimpleAuth::Config.unauthenticated_message
        end
        render '/sessions/new'
      end

      def destroy
        if logged_in?
          log_out!
          flash.notice = SimpleAuth::Config.logged_out_message
        end
        redirect_to '/sessions/new'
      end
    end
  end
end
