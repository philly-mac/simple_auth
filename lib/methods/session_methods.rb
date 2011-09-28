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
          current_user = user
          redirect_to params[:redirect_path] || '/', :notice => SimpleAuth::Config.logged_in_message
        else
          flash.now[:alert] = SimpleAuth::Config.unauthenticated_message
          render '/sessions/new'
        end
      end

      def destroy
        if logged_in?
          log_out
          flash.notice = SimpleAuth::Config.logged_out_message
        end
        redirect_to '/sessions/new'
      end
    end
  end
end

