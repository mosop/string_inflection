# Crystal String Inflection

Yet another Crystal library for string inflection.

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
StringInflection.plural("child")   # => "children"
StringInflection.singular("data")  # => "datum"
```

Or do you like shorthand? So you can use the `Case` module.

```crystal
require "string_inflection/case"

Case.camel("foo bar")  # => "fooBar"
Case.pascal("foo bar") # => "FooBar"
Case.snake("foo bar")  # => "foo_bar"
Case.kebab("foo bar")  # => "foo-bar"
Case.plural("child")   # => "children"
Case.singular("data")  # => "datum"
```

## Upper Case Replacement

With the `:up` option, `singular` / `plural` replaces a string with upper case letters.

```crystal
StringInflection.plural("CHILD", up: true) # => "CHILDREN"
StringInflection.singular("DATA", up: true)  # => "DATUM"
```

Note: `:up` affects only a replaced substring.

```crystal
StringInflection.plural("child", up: true) # => "childREN"
StringInflection.singular("data", up: true)  # => "datUM"
```

## String#to

The special extension `String#to` makes things object-oriented.

```crystal
require "string_inflection/string/to"
```

Then you can:

```crystal
"foo bar".to.camel # => "fooBar"
"foo bar".to.pascal # => "FooBar"
"foo bar".to.snake  # => "foo_bar"
"foo bar".to.kebab  # => "foo-bar"
"child".to.plural   # => "children"
"data".to.singular  # => "datum"
```

## Naming Methods

[WIP]

You can define inflection methods with your own names under your own namespaces.

## Special Thanks

### [Automatically Generated Inflection Database (AGID)](http://wordlist.aspell.net/agid-readme/)

The handy database by Kevin Atkinson and other authors is significantly useful to generate irregular singular/plural forms. You can see the license in [README](https://github.com/mosop/agid/blob/master/src/ext/agid/README).

## Releases

* v0.2.0
  * (Breaking Change) StringInflection.define_inflector is separated into StringInflection.define_inflector and StringInflection.define_inflector_methods.
* v0.1.7
  * Upper Case Replacement
* v0.1.3
  * StringInflection.singular
* v0.1.2
  * StringInflection.plural
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
