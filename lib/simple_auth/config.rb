module SimpleAuth
  class Config

    @@library = nil

    def self.library=(library)
      if [:datamapper, :sequel, :mongodb].include?(library)
        @@library = library
      else
        @@library = nil
        raise "#{library}: Not a valid SimpleAuth library"
      end
    end

    def self.library
      if @@library
        @@library
      else
        raise "No SimpleAuth library set"
      end
    end

  end
end