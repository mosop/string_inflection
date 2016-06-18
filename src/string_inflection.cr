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

  macro define_instance_method(method, object)
    def {{method.id}}
      ::StringInflection.{{method.id}}({{object}})
    end
  end

  macro define_instance_methods(object)
    ::StringInflection.define_instance_method camel, {{object}}
    ::StringInflection.define_instance_method pascal, {{object}}
    ::StringInflection.define_instance_method snake, {{object}}
    ::StringInflection.define_instance_method kebab, {{object}}
  end

  module StaticMethods
    ::StringInflection.define_static_methods
  end

  macro define_inflector(name = "to", class_name = "StringInflector", object = "self")
    class {{class_name.id}}
      @string : ::String

      def initialize(@string)
      end

      ::StringInflection.define_instance_methods @string
    end

    def {{name.id}}
      {{class_name.id}}.new({{object.id}})
    end
  end
end
