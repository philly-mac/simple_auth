module SimpleAuth
  module Methods
    module UserMethods

      def index
      end

      def new
        @user = user_class(params[:controller]).new
      end

      def create
        @user = user_class(params[:controller]).new params[:user]

        if @user.save
          notice = SimpleAuth::Config.registration_successful_message
          redirect_to '/'
        else
          alert.now = SimpleAuth::Config.registration_unsuccessful_message
          render '/users/new'
        end
      end

      def edit
        @user = User.new
        render '/users/edit'
      end

      def update
        @user = user_class(params[:controller]).new params[:user]

        if @user.save
          notice = SimpleAuth::Config.update_successful_message
          redirect_to '/'
        else
          alert.now = SimpleAuth::Config.update_unsuccessful_message
          render '/users/new'
        end
      end

      def confirm
        if user_class(params[:controller]).activate params[:confirm_code]
          notice = SimpleAuth::Config.registration_confirmed_message
          redirect '/'
        else
          alert = SimpleAuth::Config.registration_not_confirmed_message
          redirect '/'
        end
      end
    end
  end
end
