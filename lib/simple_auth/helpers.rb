module SimpleAuth
  module Helpers

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

    def user_model
      # Please overwrite this method in the controller you
      # include it into
      raise "You have not overwritten the user_model method yet!"
    end

  private

    def serialize_current_user(user)
      session[:logged_in_user] = user.id.to_s
    end

    def unserialize_current_user
      return @current_user if @current_user
      return nil           if !session[:logged_in_user]

      method_call = defined?(::DataMapper) ? 'get' : 'find'
      @current_user = user_model.send(method_call, session[:logged_in_user])
      @current_user
    end

  end
end

