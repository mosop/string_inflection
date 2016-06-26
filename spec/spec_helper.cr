require "spec"
require "../src/string_inflection"
require "../src/case"
require "../src/string/to"
require "../src/agid"

module StringInflection::Test
  class StaticMethods
    extend ::StringInflection::StaticMethods
  end

  class InstanceMethods
    ::StringInflection.define_instance_methods @string

    @string : ::String

    def initialize(@string)
    end
  end
end

class String
  ::StringInflection.define_inflector name: "inflect_to", class_name: "InflectTo"
end
