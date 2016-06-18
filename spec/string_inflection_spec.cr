require "./spec_helper"
require "../src/string_inflection/case"
require "../src/string_inflection/string/to"

TWO_WORDS = [
  "fooBar",
  "FooBar",
  "foo_bar",
  "foo-bar",
  "foo bar"
]

macro test(method, two_words)
  describe ".{{method.id}}" do
    TWO_WORDS.each do |source|
      it "converts #{source} to {{two_words.id}}" do
        StringInflection.{{method.id}}(source).should eq {{two_words}}
        Case.{{method.id}}(source).should eq {{two_words}}
        StringInflection::Test::StaticMethods.{{method.id}}(source).should eq {{two_words}}
        StringInflection::Test::InstanceMethods.new(source).{{method.id}}.should eq {{two_words}}
        source.to.{{method.id}}.should eq {{two_words}}
        source.inflectTo.{{method.id}}.should eq {{two_words}}
      end
    end
  end
end

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
  ::StringInflection.define_inflector name: "inflectTo", class_name: "InflectTo"
end

describe StringInflection do
  test "camel", "fooBar"
  test "pascal", "FooBar"
  test "snake", "foo_bar"
  test "kebab", "foo-bar"
end
