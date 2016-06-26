require "spec"
require "../src/string_inflection"
require "../src/string_inflection/case"
require "../src/string_inflection/string/to"
require "../src/string_inflection/agid"

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
