require "../../camel"

class String
  ::StringInflection.define_inflector
  ::StringInflection.define_inflector_method :camel
end
