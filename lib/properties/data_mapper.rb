module SimpleAuth
  module Properties
    module DataMapper

      def self.included(base)
        base.class_eval do

          include ::DataMapper::Resource

          attr_accessor :password, :password_confirmation

          property :id,               ::DataMapper::Property::Serial
          property :email,            ::DataMapper::Property::String,  :default => '', :length => (5..255), :format => :email_address, :unique => true
          property :username,         ::DataMapper::Property::String,  :default => ''
          property :crypted_password, ::DataMapper::Property::String,  :default => '', :length => (10..255)
          property :perishable_token, ::DataMapper::Property::String,  :default => '', :length => 255, :unique => true
          property :activated,        ::DataMapper::Property::Boolean, :default => false
          property :activated_at,     ::DataMapper::Property::DateTime

          timestamps :at

          validates_length_of       :username, :if => :username_entered?, :in => (6..32)
          validates_uniqueness_of   :username, :if => :username_entered?
          validates_uniqueness_of   :email
          validates_presence_of     :password, :password_confirmation, :if => :new?
          validates_confirmation_of :password, :if => Proc.new {|u| !u.password.blank? }

          before :valid? do
            encrypt_password if password_changed_requested?
            create_perishable_token if new?
          end

        end
      end
    end
  end
end
