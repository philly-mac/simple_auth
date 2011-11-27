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

          class << self

            def get(id)
              self[id]
            end

            def simple_auth_allowed_colums(additional_attributes)
              additional_attributes = [additional_attributes].flatten
              set_allowed_columns *([:email, :username, :password, :password_confirmation] + additional_attributes)
            end
          end

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
            # qtext          = '[^\\x0d\\x22\\x5c\\x80-\\xff]'
            # dtext          = '[^\\x0d\\x5b-\\x5d\\x80-\\xff]'
            # atom           = '[^\\x00-\\x20\\x22\\x28\\x29\\x2c\\x2e\\x3a-\\x3c\\x3e\\x40\\x5b-\\x5d\\x7f-\\xff]+'
            # quoted_pair    = '\\x5c[\\x00-\\x7f]'
            # domain_literal = '\\x5b(?:#{dtext}|#{quoted_pair})*\\x5d'
            # quoted_string  = "\\x22(?:#{qtext}|#{quoted_pair})*\\x22"
            # domain_ref     = atom
            # sub_domain     = "(?:#{domain_ref}|#{domain_literal})"
            # word           = "(?:#{atom}|#{quoted_string})"
            # domain         = "#{sub_domain}(?:\\x2e#{sub_domain})*"
            # local_part     = "#{word}(?:\\x2e#{word})*"
            # addr_spec      = "#{local_part}\\x40#{domain}"
            # /\A#{addr_spec}\z/
            /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i
          end

          def simple_auth_before_save
            encrypt_password        if password_changed_requested?
            create_perishable_token if new?
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
