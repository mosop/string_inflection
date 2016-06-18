# Crystal String Inflection

Yet another library for string inflection written in Crystal.

[![Build Status](https://travis-ci.org/mosop/string_inflection.svg?branch=master)](https://travis-ci.org/mosop/string_inflection)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  string_inflection:
    github: mosop/string_inflection
```

## Usage

```crystal
require "string_inflection"

StringInflection.camel("foo bar")  # => "fooBar"
StringInflection.pascal("foo bar") # => "FooBar"
StringInflection.snake("foo bar")  # => "foo_bar"
StringInflection.kebab("foo bar")  # => "foo-bar"
```

Or do you like shorthand? So you can use the `Case` module.

```crystal
require "string_inflection/case"

Case.camel("foo bar")  # => "fooBar"
Case.pascal("foo bar") # => "FooBar"
Case.snake("foo bar")  # => "foo_bar"
Case.kebab("foo bar")  # => "foo-bar"
```

## String#to

The special extension `String#to` makes things object-oriented.

```crystal
require "string_inflection/string/to"
```

Then you can:

```crystal
"foo bar".to.camel # => "fooBar"
```

If you don't intend pollute the String's namespace with the method #to, the `StringInflection.define_inflector` macro helps you.

```crystal
class String
  StringInflection.define_inflector name: "inflectTo"
end
```

And you can:

```crystal
"foo bar".inflectTo.camel
```

## Mixins

You can mix the inflector methods into your own namespace.

```crystal
module Case
  extend StringInflection::StaticMethods
end
```

This code defines all the inflector methods into the Case module. So you can:

```crystal
Case.camel("foo bar")
```

You can also define the inflector methods as  instance methods.

```crystal
class String
  StringInflection.define_instance_methods self
end
```

And you can:

```crystal
"foo bar".camel
```

Calling the `StringInflection.define_instance_methods(object)` macro, the inflector methods will be defined like:

```crystal
class String
  def camel
    StringInflection.camel(self)
  end
end
```

## Releases

* v0.1.1
  * Case
  * String#to
  * StringInflection.define_inflector

## Development

[WIP]

## Contributing

1. Fork it ( https://github.com/mosop/string_inflection/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [mosop](https://github.com/mosop) - creator, maintainer
