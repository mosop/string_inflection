require "./version"
require "./singulars"
require "./plurals"

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

  SEPARATOR_PATTERN = /[^a-zA-Z0-9]|[a-z0-9](?=[A-Z])/
  SINGULAR_SUFFIXES = [
    {re: /([sxz])$/i, tail: ["es", "ES"]},
    {re: /y$/i, tail: ["ies", "IES"]},
    {re: /(m)an$/i, tail: ["en", "EN"]},
  ]

  def self.plural(this, **options)
    a = this.split(SEPARATOR_PATTERN)
    s = a.last.dup
    dicts = options[:dicts]? || [SINGULARS]
    tail = options[:up]? ? 1 : 0
    if (begin
      downcased = s.downcase
      diff = nil
      dicts.any?{|dict| diff = dict[downcased]?}
      diff && (s = s[0..(-1 - diff[:cut])] + diff[:tail][tail])
    end)
    else
      unless SINGULAR_SUFFIXES.any?{|i|
        if md = i[:re].match(s)
          s = "#{md.pre_match}#{md[1]?}#{i[:tail][tail]}"
        end
      }
        s += (options[:up]? ? 'S' : 's')
      end
    end
    this[0, this.size - a.last.size] + s
  end

  PLURAL_SUFFIXES = [
    {re: /([hosxz])es$/i, tail: ["", ""]},
    {re: /ies$/i, tail: ["y", "Y"]},
    {re: /(m)en$/i, tail: ["an", "AN"]},
  ]

  def self.singular(this, **options)
    a = this.split(SEPARATOR_PATTERN)
    s = a.last.dup
    dicts = options[:dicts]? || [PLURALS]
    tail = options[:up]? ? 1 : 0
    if (begin
      downcased = s.downcase
      diff = nil
      dicts.any?{|dict| diff = dict[downcased]?}
      diff && (s = s[0..(-1 - diff[:cut])] + diff[:tail][tail])
    end)
    else
      unless PLURAL_SUFFIXES.any?{|i|
        if md = i[:re].match(s)
          s = "#{md.pre_match}#{md[1]?}#{i[:tail][tail]}"
        end
      }
        s = s.chop
      end
    end
    this[0, this.size - a.last.size] + s
  end

  macro define_static_method(method)
    def {{method.id}}(s, **options)
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
