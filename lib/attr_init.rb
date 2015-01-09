require "attr_init/version"

def attr_init(*attrs)
  define_method(:attr_init) do |params|
    attrs.each do |a|
      instance_variable_set "@#{a}", params[a]
    end
  end

  protected :attr_init

  define_method(:initialize) do |params|
    attr_init(params)
  end
end

def reader_struct(*attrs)
  attr_reader *attrs
  attr_init *attrs
end

def accessor_struct(*attrs)
  attr_accessor *attrs
  attr_init *attrs
end

module AttrInit
end
