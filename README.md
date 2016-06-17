# Crystal String Inflection

Yet another library for string inflection written in Crystal.

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

StringInflection.camel("foo bar") # => "fooBar"
StringInflection.pascal("foo bar") # => "FooBar"
StringInflection.snake("foo bar") # => "foo_bar"
StringInflection.kebab("foo bar") # => "foo-bar"
```

## Mixin

You can mix the inflector methods into your own namespace.

```crystal
module Case
  extend StringInflection::StaticMethods
end
```

This code defines all the inflector methods into the Case class. So you can:

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

```
"foo bar".camel
```

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
