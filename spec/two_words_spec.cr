require "./spec_helper"

module StringInflection::Test
  TWO_WORDS = [
    "fooBar",
    "FooBar",
    "foo_bar",
    "foo-bar",
    "foo bar"
  ]

  macro two_words(method, two_words)
    describe ".{{method.id}}" do
      TWO_WORDS.each do |source|
        it "converts #{source} to {{two_words.id}}" do
          StringInflection.{{method.id}}(source).should eq {{two_words}}
          Case.{{method.id}}(source).should eq {{two_words}}
          StaticMethods.{{method.id}}(source).should eq {{two_words}}
          InstanceMethods.new(source).{{method.id}}.should eq {{two_words}}
          source.to.{{method.id}}.should eq {{two_words}}
          source.inflectTo.{{method.id}}.should eq {{two_words}}
        end
      end
    end
  end

  describe "Two Words" do
    two_words "camel", "fooBar"
    two_words "pascal", "FooBar"
    two_words "snake", "foo_bar"
    two_words "kebab", "foo-bar"
  end
end
