base = File.dirname(File.expand_path(__FILE__))

require "#{base}/lib/util"
require "#{base}/lib/config"
require "#{base}/lib/helpers"
require "#{base}/lib/model_methods"

require "#{base}/lib/setup"

require "#{base}/lib/common/model_methods"
require "#{base}/lib/common/session_methods"

require "#{base}/lib/methods/session_methods"
require "#{base}/lib/methods/model_methods"

require "#{base}/lib/http_verbs/session_methods"
require "#{base}/lib/http_verbs/model_methods"

require "#{base}/lib/properties/data_mapper"
require "#{base}/lib/properties/sequel"
require "#{base}/lib/properties/mongoid"