module SimpleAuth
  class Config

    class << self

      def setup
        yield self
      end

      def class_attr_accessor(name)
        name = name.to_s.gsub("=", '')
        getter = :"#{name}"
        setter = :"#{name}="

        define_singleton_method :"#{setter}" do |new_val|
          class_variable_set "@@#{name}", new_val
        end

        define_singleton_method :"#{getter}" do
          class_variable_get "@@#{name}"
        end
      end

      def method_missing(method_sym, *arguments, &block)
        class_attr_accessor method_sym
        send method_sym, *arguments
      end

    end

  end

end

