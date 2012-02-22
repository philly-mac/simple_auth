module SimpleAuth
  class Util
    class << self

      def to_params(params)
        defined?(::Mongoid) ? {conditions: params} : params
      end
    end
  end
end