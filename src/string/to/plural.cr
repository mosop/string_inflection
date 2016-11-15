require "../../plural"

class String
  ::StringInflection.define_inflector
  ::StringInflection.define_inflector_method :plural
end
