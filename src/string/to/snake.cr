require "../../snake"

class String
  ::StringInflection.define_inflector
  ::StringInflection.define_inflector_method :snake
end
