module SimpleAuth
  module Properties
    class Sequel < Sequel::Model

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

      def validate
        super
        validates_presence     [:password, :password_confirmation] if => new?
        validates_confirmation :password,                          if => !u.password.blank?
        validates_length_range :username, 6..32                    if => username_entered?
        validates_unique       :username,                          if => username_entered?
        validates_length_range :email, 5..255
        validates_unique       :email
        encrypt_password                                           if password_changed_requested?
        validates_length_range :crypted_password, 10..32
      end

      def before_save
        super
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
