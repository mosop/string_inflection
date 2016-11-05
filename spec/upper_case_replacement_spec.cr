require "./spec_helper"

module StringInflection::Test
  module UpperCaseReplacement
    PREFIXES = [
      "Foo ",
      "Foo-",
      "Foo_",
      "Foo"
    ]

    macro expect(method, source, expected)
      it "{{source.id}} to {{expected.id}}" do
        StringInflection.{{method.id}}({{source}}, up: true).should eq {{expected}}
        Case.{{method.id}}({{source}}, up: true).should eq {{expected}}
        StaticMethods.{{method.id}}({{source}}, up: true).should eq {{expected}}
        InstanceMethods.new({{source}}).{{method.id}}(up: true).should eq {{expected}}
        {{source}}.to.{{method.id}}(up: true).should eq {{expected}}
        {{source}}.inflect_to.{{method.id}}(up: true).should eq {{expected}}
      end
    end

    describe name do
      context "singular" do
        expect :singular, "FOOS", "FOO"
        expect :singular, "DATA", "DATUM"
        expect :singular, "data", "datUM"
      end

      context "to_plural" do
        expect :plural, "FOO", "FOOS"
        expect :plural, "CHILD", "CHILDREN"
        expect :plural, "child", "childREN"
      end
    end
  end
end
