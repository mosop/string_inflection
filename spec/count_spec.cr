require "./spec_helper"

module StringInflection::Test
  macro count(method, source, expected)
    it "converts {{source.id}} to {{expected.id}}" do
      StringInflection.{{method.id}}({{source}}).should eq {{expected}}
      Case.{{method.id}}({{source}}).should eq {{expected}}
      StaticMethods.{{method.id}}({{source}}).should eq {{expected}}
      InstanceMethods.new({{source}}).{{method.id}}.should eq {{expected}}
      {{source}}.to.{{method.id}}.should eq {{expected}}
      {{source}}.inflect_to.{{method.id}}.should eq {{expected}}
    end
  end

  describe "plural" do
    count "plural", "child", "children"
  end
end
