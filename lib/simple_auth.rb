base = File.dirname(File.expand_path(__FILE__))

# Application root
SIMPLE_AUTH_APP_ROOT = "#{File.dirname(File.expand_path(__FILE__))}/.."

$: << "#{SIMPLE_AUTH_APP_ROOT}/lib"

require "simple_auth/util"
require "simple_auth/config"
require "simple_auth/helpers"
require "simple_auth/model_methods"

require "simple_auth/setup"

require "simple_auth/common/model_methods"
require "simple_auth/common/session_methods"

require "simple_auth/methods/session_methods"
require "simple_auth/methods/model_methods"

require "simple_auth/http_verbs/session_methods"
require "simple_auth/http_verbs/model_methods"

require "simple_auth/properties/data_mapper"
require "simple_auth/properties/sequel"
require "simple_auth/properties/mongoid"