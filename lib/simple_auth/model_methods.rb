module SimpleAuth
  module ModelMethods

    def self.included(base)
      base.class_eval do
        extend  ClassMethods
        include InstanceMethods
      end
    end

    module ClassMethods

      def activate!(token)
        if resource = SimpleAuth::Util.first(self, {:perishable_token => token})
          resource.activate!
          resource
        else
          nil
        end
      end

      def authenticate(email, password)
        resource = SimpleAuth::Util.first(self, {:email => email})
        resource && resource.has_password?(password) ? resource : nil
      end

    end

    module InstanceMethods

      def create_perishable_token
        token = ''
        begin
          token = SecureRandom.urlsafe_base64(64)
        end while SimpleAuth::Util.first(self, {:perishable_token => token})
        self.perishable_token = token
      end

      def username_entered?
        !username.blank?
      end

      def password_changed_requested?
        password.present? && password_confirmation.present?
      end

      def encrypt_password
        self.crypted_password = BCrypt::Password.create(password, :cost => 10) if password.present?
      end

      def has_password?(password)
        BCrypt::Password.new(crypted_password) == password
      end

      def active?
        activated && !activated_at.nil? && (/time/i =~ activated_at.class.to_s)
      end

      def set_as_active
        self.activated = true
        self.activated_at = Time.now
        create_perishable_token
        SimpleAuth::Config.library == :datamapper ? save! : save(:validate => false)
      end
      alias_method :activate!, :set_as_active
    end
  end

end
