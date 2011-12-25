module SimpleAuth
  module Methods
    module ModelMethods

      def self.included(base)
        base.class_eval do
          include InstanceMethods
        end
      end

      module InstanceMethods

        def index
          SimpleAuth::Common::UserMethods.method_index(self, params)
        end

        def new
          SimpleAuth::Common::UserMethods.method_new(self, params)
        end

        def create
          SimpleAuth::Common::UserMethods.method_create(self, params)
        end

        def edit
          SimpleAuth::Common::UserMethods.method_edit(self, params)
        end

        def update
          SimpleAuth::Common::UserMethods.method_update(self, params)
        end

        def confirm
          SimpleAuth::Common::UserMethods.method_confirm(self, params)
        end

        def confirmation_resend_form
          SimpleAuth::Common::UserMethods.method_confirm_resend_form(self, params)
        end

        def confirmation_resend
          SimpleAuth::Common::UserMethods.method_confirm_resend(self, params)
        end

        def forgot_password
          SimpleAuth::Common::UserMethods.method_forgot_password_form(self, params)
        end

        def password_resend
          SimpleAuth::Common::UserMethods.method_forgot_password(self, params)
        end

      end

    end
  end
end

