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
        if u = first(SimpleAuth::Util.to_params({perishable_token: token}))
          u.activate!
          u
        else
          nil
        end
      end

      def authenticate(email, password)
        u = self.first(SimpleAuth::Util.to_params({:email => email}))
        u && u.has_password?(password) ? u : nil
      end

    end

    module InstanceMethods

      def create_perishable_token
        token = ''
        begin
          token = SecureRandom.urlsafe_base64(64)
        end while self.class.first(SimpleAuth::Util.to_params({perishable_token: token}))
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
        defined?(::DataMapper) ? save! : save(:validate => false)
      end
      alias_method :activate!, :set_as_active
    end
  end

end
