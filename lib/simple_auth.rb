$: << "#{File.dirname(File.expand_path(__FILE__))}/../lib"

require "simple_auth/util"
require "simple_auth/helpers"
require "simple_auth/model_methods"

require "simple_auth/properties/data_mapper"
require "simple_auth/properties/sequel"
require "simple_auth/properties/mongoid"