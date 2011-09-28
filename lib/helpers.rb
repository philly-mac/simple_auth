module SimpleAuth
  module Helpers

    def current_user
      unserialize_current_user
    end

    def current_user=(user)
      serialize_current_user(user)
    end

    def log_out
      session[:user_id] = nil
      session[:user_class] = nil
    end

    def logged_in?
      current_user != nil
    end

    def logged_out?
      !logged_in?
    end

    def serialize_current_user(user)
      session[:user] = "#{user.class}:#{user.id}"
    end

    def unserialize_current_user
      if session[:user] =~ /^(.+):(\d+)$/
        user_object = Kernel.const_get($1) unless $1.nil
        user_id = $2.to_i unless $2.nil

        $1 && $2 ? user_object.find(user_id) : nil
      else
        nil
      end
    end

    def user_class(key)
      SimpleAuth::Config.user_objects(key)
    end

  end
end

