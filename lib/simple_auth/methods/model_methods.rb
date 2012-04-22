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
          SimpleAuth::Common::ModelMethods.method_index(self, params)
        end

        def new
          SimpleAuth::Common::ModelMethods.method_new(self, params)
        end

        def create
          SimpleAuth::Common::ModelMethods.method_create(self, params)
        end

        def edit
          SimpleAuth::Common::ModelMethods.method_edit(self, params)
        end

        def update
          SimpleAuth::Common::ModelMethods.method_update(self, params)
        end

        def confirm
          SimpleAuth::Common::ModelMethods.method_confirm(self, params)
        end

        def confirmation_resend_form
          SimpleAuth::Common::ModelMethods.method_confirm_resend_form(self, params)
        end

        def confirmation_resend
          SimpleAuth::Common::ModelMethods.method_confirm_resend(self, params)
        end

        def forgot_password
          SimpleAuth::Common::ModelMethods.method_forgot_password_form(self, params)
        end

        def password_resend
          SimpleAuth::Common::ModelMethods.method_forgot_password(self, params)
        end

      end

    end
  end
end

