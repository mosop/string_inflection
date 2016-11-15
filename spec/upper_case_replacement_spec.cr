require "./require_all_spec_helper"

module StringInflectionTest
  module UpperCaseReplacement
    macro expect(method, source, expected)
      ::StringInflectionTest.expect_method {{method}}, {{source}}, {{expected}}, up: true
    end

    describe name do
      context "singular" do
        expect :singular, "FOOS", "FOO"
        expect :singular, "DATA", "DATUM"
        expect :singular, "data", "datUM"
      end

      context "plural" do
        expect :plural, "FOO", "FOOS"
        expect :plural, "CHILD", "CHILDREN"
        expect :plural, "child", "childREN"
      end
    end
  end
end
