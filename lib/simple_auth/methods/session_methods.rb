module SimpleAuth
  module Methods
    module SessionMethods

      def index
        SimpleAuth::Common::SessionMethods.login_method_form(self, params)
      end

      def new
        SimpleAuth::Common::SessionMethods.login_method_form(self, params)
      end

      def create
        SimpleAuth::Common::SessionMethods.login_method(self, params)
      end

      def destroy
        SimpleAuth::Common::SessionMethods.logout_method(self, params)
      end
    end
  end
end
