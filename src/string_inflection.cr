require "./string_inflection/version"

module StringInflection
  def self.camel(s)
    s.gsub(/[\s\-]+/, "_").camelcase.sub(/^./){|s| s.downcase}
  end

  def self.pascal(s)
    s.gsub(/[\s\-]+/, "_").camelcase
  end

  def self.snake(s)
    s.gsub(/[\s\-]+/, "_").underscore
  end

  def self.kebab(s)
    s.gsub(/[\s\-]+/, "_").underscore.gsub(/_/, "-")
  end

  macro define_static_method(method)
    def {{method.id}}(s)
      ::StringInflection.{{method.id}}(s)
    end
  end

  macro define_static_methods
    ::StringInflection.define_static_method camel
    ::StringInflection.define_static_method pascal
    ::StringInflection.define_static_method snake
    ::StringInflection.define_static_method kebab
  end

  macro define_instance_method(method, s)
    def {{method.id}}
      ::StringInflection.{{method.id}}({{s}})
    end
  end

  macro define_instance_methods(s)
    ::StringInflection.define_instance_method camel, {{s}}
    ::StringInflection.define_instance_method pascal, {{s}}
    ::StringInflection.define_instance_method snake, {{s}}
    ::StringInflection.define_instance_method kebab, {{s}}
  end

  module StaticMethods
    ::StringInflection.define_static_methods
  end
end
