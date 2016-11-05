require "./spec_helper"

module StringInflection::Test
  module CountForMultipleWords
    PREFIXES = [
      "Foo ",
      "Foo-",
      "Foo_",
      "Foo"
    ]

    macro expect(method, source_word, expected_word)
      PREFIXES.each do |prefix|
        source = prefix + {{source_word}}
        expected = prefix + {{expected_word}}
        it "#{source} to #{expected}" do
          StringInflection.{{method.id}}(source).should eq expected
          Case.{{method.id}}(source).should eq expected
          StaticMethods.{{method.id}}(source).should eq expected
          InstanceMethods.new(source).{{method.id}}.should eq expected
          source.to.{{method.id}}.should eq expected
          source.inflect_to.{{method.id}}.should eq expected
        end
      end
    end

    describe name do
      context "singular" do
        expect :singular, "Bars", "Bar"
        expect :singular, "Data", "Datum"
      end

      context "plural" do
        expect :plural, "Bar", "Bars"
        expect :plural, "Child", "Children"
      end
    end
  end
end
