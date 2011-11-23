base = File.dirname(File.expand_path(__FILE__))

require "#{base}/lib/config"
require "#{base}/lib/helpers"
require "#{base}/lib/user_methods"

require "#{base}/lib/setup"

require "#{base}/lib/common/user_methods"

require "#{base}/lib/methods/session_methods"
require "#{base}/lib/methods/user_methods"

require "#{base}/lib/http_verbs/session_methods"
require "#{base}/lib/http_verbs/user_methods"

require "#{base}/lib/properties/data_mapper"
require "#{base}/lib/properties/sequel"