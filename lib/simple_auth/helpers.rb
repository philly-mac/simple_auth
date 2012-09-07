module SimpleAuth
  module Helpers

    def authenticate!(scope = :default)
      unless logged_in?(scope)
        yield if block_given?
      end
    end

    def current_user(scope = :default)
      load_current_user(scope)
    end

    def current_user=(user, scope = :default)
      store_current_user(user, scope)
    end

    def log_out!(scope = :default)
      if session[:logged_in_user]
        if session[:logged_in_user].is_a?(Hash)
          session[:logged_in_user][scope] = nil
        else
          session[:logged_in_user] = {}
        end
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

    def store_current_user(user, scope = :default)
      session[:logged_in_user]        = {} if !session[:logged_in_user] || !session[:logged_in_user].is_a?(Hash)
      session[:logged_in_user][scope] = user.id.to_s
    end

    def load_current_user(scope = :default)
      return @current_user if @current_user
      session[:logged_in_user] = {} if !session[:logged_in_user].is_a?(Hash)
      return nil                    if session[:logged_in_user].to_s.strip == '' || session[:logged_in_user][scope].to_s.strip == ''

      method_call = defined?(::DataMapper) ? 'get' : 'find'
      @current_user = user_model.send(method_call, session[:logged_in_user][scope])
      @current_user
    end

  end
end

