require "../../singular"

class String
  ::StringInflection.define_inflector
  ::StringInflection.define_inflector_method :singular
end
