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
        user = SimpleAuth::Config.user_objects[params[:user_type]].authenticate(
          params[SimpleAuth::Config.login_field],
          parsms[SimpleAuth::Config.password_field]
        )

        if user
          current_user = user
          notice = SimpleAuth::Config.logged_in_message
          redirect params[:redirect_path] || '/'
        else
          alert.now = SimpleAuth::Config.unauthenticated_message
          render '/sessions/new'
        end
      end

      def destroy
        if logged_in?
          log_out
          notice = SimpleAuth::Config.logged_out_message
        end
        redirect '/sessions/new'
      end
    end
  end
end