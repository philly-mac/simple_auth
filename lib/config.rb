module SimpleAuth
  class Config

    class << self

      def self.setup
        yield self
      end

      def class_attr_accessor(name)
        define_method name do
          class_variable_get "@@#{name}"
        end
        define_method "#{name}=" do |new_val|
          class_variable_set "@@#{name}" new_val
        end
      end

      def method_missing(method_sym, *arguments, &block)
        class_attr_accessor method_sym
        send method_sym, *arguments
      end

    end

  end

end