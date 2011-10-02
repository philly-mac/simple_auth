module SimpleAuth
  module Methods
    module UserMethods

      def self.included(base)
        base.class_eval do
          include InstanceMethods
        end
      end

      module InstanceMethods

        def index
        end

        def new
          @user = SimpleAuth::Config.user_object.new
        end

        def create
          @user = SimpleAuth::Config.user_object.new params[:user]

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
          @user = SimpleAuth::Config.user_object.new params[:user]

          if @user.save
            notice = SimpleAuth::Config.update_successful_message
            redirect_to '/'
          else
            alert.now = SimpleAuth::Config.update_unsuccessful_message
            render '/users/new'
          end
        end

        def confirm
          if SimpleAuth::Config.user_object.activate params[:confirmation_code]
            notice = SimpleAuth::Config.registration_confirmed_message
            redirect_to '/'
          else
            alert = SimpleAuth::Config.registration_not_confirmed_message
            redirect_to '/'
          end
        end

      end

    end
  end
end

