module SimpleAuth
  module Helpers

    def authenticate!(scope = :default)
      unless current_user(scope)
        yield if block_given?
      end
    end

    def current_user(scope = :default)
      unserialize_current_user(scope)
    end

    def current_user=(user, scope = :default)
      serialize_current_user(user, scope)
    end

    def log_out!(scope = :default)
      if session[:logged_in_user]
        session[:logged_in_user][scope] = nil
      end
    end

    def logged_in?(scope = :default)
      !current_user(scope).nil?
    end

    def logged_out?(scope = :default)
      !logged_in?(scope)
    end

    def user_model
      # Please overwrite this method in the controller you
      # include it into
      raise "You have not overwritten the user_model method yet!"
    end

  private

    def serialize_current_user(user, scope = :default)
      session[:logged_in_user] = {} unless session[:logged_in_user]
      session[:logged_in_user][scope] = user.id.to_s
    end

    def unserialize_current_user(scope = :default)
      return @current_user if @current_user
      return nil           if !session[:logged_in_user] || !session[:logged_in_user][scope]

      method_call = defined?(::DataMapper) ? 'get' : 'find'
      @current_user = user_model.send(method_call, session[:logged_in_user][scope])
      @current_user
    end

  end
end

