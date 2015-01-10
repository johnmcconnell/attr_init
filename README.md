# AttrInit
[![Gem
Version](https://badge.fury.io/rb/attr_init.svg)](http://badge.fury.io/rb/attr_init)
[![Build
Status](https://travis-ci.org/johnmcconnell/attr_init.svg?branch=master)](https://travis-ci.org/johnmcconnell/attr_init)
[![Coverage
Status](https://coveralls.io/repos/johnmcconnell/attr_init/badge.png)](https://coveralls.io/r/johnmcconnell/attr_init)

So ruby has `Struct` but I never use it because:
  1. I have to extend the class with `Struct`
  2. It makes your instance_variables public
  3. It does not use hash initialization

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'attr_init'
```


And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attr_init

## Usage

### Initializer

```ruby
class Foo
  attr_init :a, :b
end

f = Foo.new(a: 0, b: 1)
=> #<Foo:0xb811601c @a=0, @b=1>

f.a
NoMethodError: undefined method: a' for #<Bar:0xb811601c @a=0, @b=1>
```
If you want to you can override it:

```ruby

class Foo
  attr_init :a, :b
  def initialize(params, opt=nil)
    if opt.nil?
      do_other_initializer
    else
      attr_init(params)
    end
  end
end

```

### Initializer with readers

```ruby
class Bar
  reader_struct :a, :b
end

b = Bar.new(a: 0, b: 1)
=> #<Bar:0xaf11321c @a=0, @b=1>

b.a
=> 0

b.a = 2
NoMethodError: undefined method: a=' for #<Bar:0xb931e250 @a=0, @b=1>
```

### Initializer with accessors

```ruby
class Dah
  accessor_struct :a, :b
end

d = Dah.new(a: 0, b: 1)
=> #<Dah:0x81ad601c @a=0, @b=1>

d.a
=> 0

d.a = 2
=> 2
```

### Struct adds #to_h
```ruby
class Dah
  accessor_struct :a, :b
end

d = Dah.new(a: 0, b: 1)
=> #<Dah:0x81ad601c @a=0, @b=1>

d.to_h
=> {:a => 0, :b => 1}
```

## Contributing

1. Fork it ( https://github.com/[johnmcconnell]/attr_init/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
