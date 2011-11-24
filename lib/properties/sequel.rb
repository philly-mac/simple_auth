module SimpleAuth
  module Properties
    module Sequel

      def self.included(base)
        base.class_eval do

          # Copy this into your migration for users

          # create_table(:users) do
          #   primary_key :id
          #   String      :email,            :default => '', :size => 255, :unique => true
          #   String      :username,         :default => ''
          #   String      :crypted_password, :default => '', :size => 255
          #   String      :perishable_token, :default => '', :size => 255, :unique => true
          #   TrueClass   :activated,        :default => false
          #   DateTime    :activated_at
          #   DateTime    :created_at
          #   DateTime    :updated_at
          # end

          attr_accessor :password, :password_confirmation


          def simple_auth_validate
            validates_presence     [:password, :password_confirmation] if new?
            validates_confirmation :password                           if !password.blank?
            validates_length_range 6..32,       :username              if !username.blank?
            validates_unique       :username                           if !username.blank?
            validates_length_range 5..255,      :email
            validates_unique       :email
            validates_format       email_regex, :email
          end

          def email_regex
            /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i
          end

          def simple_auth_before_save
            encrypt_password        if password_changed_requested?
            create_perishable_token if new?
            validates_length_range 10..255,      :crypted_password
          end

          def validates_confirmation(attribute)
            attr_value = send(attribute)
            attr_confirm_value = send(:"#{attribute}_confirmation")
            return if attr_confirm_value == attr_value
            errors.add(:password_confirmation, "#{attribute} confirmation does not match #{attribute}")
          end

        end

      end

    end
  end
end
