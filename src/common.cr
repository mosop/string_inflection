require "./version"

module StringInflection
  macro define_static_method(method)
    def self.{{method.id}}(s, **options)
      ::StringInflection.{{method.id}}(s, **options)
    end
  end

  macro define_static_methods
    ::StringInflection.define_static_method camel
    ::StringInflection.define_static_method pascal
    ::StringInflection.define_static_method snake
    ::StringInflection.define_static_method kebab
    ::StringInflection.define_static_method plural
    ::StringInflection.define_static_method singular
  end

  macro define_instance_method(method, object)
    def {{method.id}}(**options)
      ::StringInflection.{{method.id}}({{object}}, **options)
    end
  end

  macro define_instance_methods(object)
    ::StringInflection.define_instance_method camel, {{object}}
    ::StringInflection.define_instance_method pascal, {{object}}
    ::StringInflection.define_instance_method snake, {{object}}
    ::StringInflection.define_instance_method kebab, {{object}}
    ::StringInflection.define_instance_method plural, {{object}}
    ::StringInflection.define_instance_method singular, {{object}}
  end

  macro define_inflector(name = "to", class_name = "StringInflector", object = "self")
    class {{class_name.id}}
      @string : ::String

      def initialize(@string)
      end
    end

    def {{name.id}}
      {{class_name.id}}.new({{object.id}})
    end
  end

  macro define_inflector_method(method, class_name = "StringInflector")
    class {{class_name.id}}
      ::StringInflection.define_instance_method {{method}}, @string
    end
  end

  macro define_inflector_methods(class_name = "StringInflector")
    ::StringInflection.define_inflector_method camel, {{class_name}}
    ::StringInflection.define_inflector_method pascal, {{class_name}}
    ::StringInflection.define_inflector_method snake, {{class_name}}
    ::StringInflection.define_inflector_method kebab, {{class_name}}
    ::StringInflection.define_inflector_method plural, {{class_name}}
    ::StringInflection.define_inflector_method singular, {{class_name}}
  end
end
