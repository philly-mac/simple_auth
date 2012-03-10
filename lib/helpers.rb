module SimpleAuth
  module Helpers

    def self.included(base)
      base.class_eval do
        include InstanceMethods
      end
    end

    module InstanceMethods

      def authenticate!
        unless current_user
          yield if block_given?
        end
      end

      def current_user
        unserialize_current_user
      end

      def current_user=(user)
        serialize_current_user(user)
      end

      def log_out!
        session[:logged_in_user] = nil
      end

      def logged_in?
        !current_user.nil?
      end

      def logged_out?
        !logged_in?
      end

    private

      def serialize_current_user(user)
        session[:logged_in_user] = "#{user.class}:#{user.id}"
      end

      def unserialize_current_user
        return @current_user if @current_user

        if /^(.+):(\w+)$/ =~ session[:logged_in_user]
          user_object = Kernel.const_get($1) unless $1.nil?
          user_id = $2

          @current_user = $1 && $2 ? user_object.find(user_id) : nil
          @current_user
        else
          nil
        end
      end
    end

  end
end

