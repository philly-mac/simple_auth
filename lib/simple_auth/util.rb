module SimpleAuth
  class Util

    def self.to_params(params)
      return case SimpleAuth::Config.library
      when :datamapper, :sequel then params
      when :mongoid             then {:conditions => params}
      end
    end

    def self.first(clazz, params)
      case SimpleAuth::Config.library
      when :datamapper, :mongoid
        clazz.first(to_params(params))
      when :sequel
        clazz.where(to_params(params)).first
      end
    end

  end
end