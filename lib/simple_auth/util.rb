module SimpleAuth
  class Util

    def self.to_params(params)
      defined?(::Mongoid) ? {conditions: params} : params
    end

  end
end