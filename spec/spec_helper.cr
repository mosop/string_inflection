require "spec"
require "../src/common"

module StringInflectionTest
  macro define_method(name)
    module StaticMethods
      StringInflection.define_static_method {{name}}
    end

    class InstanceMethods
      StringInflection.define_instance_method {{name}}, @string
    end

    class ::String
      StringInflection.define_inflector_method {{name}}, class_name: "InflectTo"
    end
  end

  module StaticMethods
  end

  class InstanceMethods
    @string : ::String
    def initialize(@string)
    end
  end

  macro expect_method(method, source, expected, up = false)
    %source = {{source}}
    %expected = {{expected}}
    it "#{%source} to #{%expected}" do
      StringInflection.{{method.id}}(%source, up: {{up}}).should eq %expected
      Case.{{method.id}}(%source, up: {{up}}).should eq %expected
      StaticMethods.{{method.id}}(%source, up: {{up}}).should eq %expected
      InstanceMethods.new(%source).{{method.id}}(up: {{up}}).should eq %expected
      %source.to.{{method.id}}(up: {{up}}).should eq %expected
      %source.inflect_to.{{method.id}}(up: {{up}}).should eq %expected
    end
  end

  TWO_WORDS = [
    "fooBar",
    "FooBar",
    "foo_bar",
    "foo-bar",
    "foo bar"
  ]

  macro expect_two_words(method, expected)
    describe {{method.id.stringify}} do
      TWO_WORDS.each do |source|
        expect_method {{method}}, source, {{expected}}
      end
    end
  end
end

class String
  StringInflection.define_inflector name: "inflect_to", class_name: "InflectTo"
end
