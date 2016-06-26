require "./spec_helper"

module StringInflection::Test
  macro count(method, list)
    {{list}}.each do |source, expected|
      it "converts #{source} to #{expected}" do
        StringInflection.{{method.id}}(source).should eq expected
        Case.{{method.id}}(source).should eq expected
        StaticMethods.{{method.id}}(source).should eq expected
        InstanceMethods.new(source).{{method.id}}.should eq expected
        source.to.{{method.id}}.should eq expected
        source.inflect_to.{{method.id}}.should eq expected
      end
    end
  end

  describe "Agid" do
    count "plural", StringInflection::Agid.singulars_plurals
    count "singular", StringInflection::Agid.plurals_singulars
  end
end
