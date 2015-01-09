# AttrInit

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'attr_init'
```

### Initializer

```ruby
class Foo
  attr_init :a, :b
end

f = Foo.new(a: 0, b: 1)
=> #<Foo:0xb811601c @a=0, @b=1>
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
f.a
NoMethodError: undefined method `a' for #<Bar:0xb811601c @a=0, @b=1>

class Bar
  reader_struct :a, :b
end

b = Bar.new(a: 0, b: 1)
=> #<Bar:0xaf11321c @a=0, @b=1>

b.a
=> 0

b.a = 2
NoMethodError: undefined method `a=' for #<Bar:0xb931e250 @a=0, @b=1>
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

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attr_init

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[johnmcconnell]/attr_init/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
