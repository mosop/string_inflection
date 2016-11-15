require "./require_all_spec_helper"

module StringInflectionTest
  module CountForMultipleWords
    PREFIXES = [
      "Foo ",
      "Foo-",
      "Foo_",
      "Foo"
    ]

    macro expect(method, source, expected)
      PREFIXES.each do |prefix|
        ::StringInflectionTest.expect_method {{method}}, prefix + {{source}}, prefix + {{expected}}
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
