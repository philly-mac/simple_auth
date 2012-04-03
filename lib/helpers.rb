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
        session[:logged_in_user] = user.id.to_s
      end

      def unserialize_current_user
        return @current_user if @current_user
        return nil           if !session[:logged_in_user]

        @current_user = SimpleAuth::Config.model_object.call.find(session[:logged_in_user])
        @current_user
      end
    end

  end
end

