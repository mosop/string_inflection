require "../../kebab"

class String
  ::StringInflection.define_inflector
  ::StringInflection.define_inflector_method :kebab
end
