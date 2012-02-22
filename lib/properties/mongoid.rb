module SimpleAuth
  module Properties
    module Mongoid

      def self.included(base)
        base.class_eval do

          include ::Mongoid::Document
          include ::Mongoid::Paranoia
          include ::Mongoid::Versioning
          include ::Mongoid::Timestamps

          attr_accessor :password, :password_confirmation

          field :email,             type: String,   default: ''
          field :username,          type: String,   default: ''
          field :crypted_password,  type: String,   default: ''
          field :perishable_token,  type: String,   default: ''
          field :activated,         type: Boolean,  default: false
          field :role,              type: String,   default: ''
          field :activated_at,      type: DateTime

          validates_length_of       :username,              :if => :username_entered?, :in => (6..32)
          validates_uniqueness_of   :username,              :if => :username_entered?
          validates_uniqueness_of   :email
          validates_format_of       :email,                 :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
          validates_uniqueness_of   :perishable_token
          validates_presence_of     :password,              :if => :new?
          validates_presence_of     :password_confirmation, :if => :new?
          validates_confirmation_of :password,              :if => Proc.new {|u| !u.password.blank? }

          before_validation do
            encrypt_password        if password_changed_requested?
            create_perishable_token if new?
            true
          end

        end
      end
    end
  end
end
