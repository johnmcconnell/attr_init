require "attr_init/version"

def attr_init(*attrs)
  begin
    hidden_attrs = superclass.class_variable_get :@@_hidden_attrs
    class_variable_set :@@_hidden_attrs, hidden_attrs + attrs
  rescue NameError => e
    class_variable_set :@@_hidden_attrs, attrs
  end

  define_method(:attr_init) do |params|
    self.class.class_variable_get(:@@_hidden_attrs).each do |a|
      instance_variable_set "@#{a}", params[a]
    end
  end

  protected :attr_init

  define_method(:initialize) do |params|
    attr_init(params)
  end
end

def attr_hash(*attrs)
  define_method(:to_h) do
    self.class.class_variable_get(:@@_hidden_attrs)
    .each_with_object({}) do |attr, hash|
      hash[attr] = public_send(attr)
    end
  end
end

def reader_struct(*attrs)
  attr_reader *attrs
  attr_init *attrs
  attr_hash *attrs
end

def accessor_struct(*attrs)
  attr_accessor *attrs
  attr_init *attrs
  attr_hash *attrs
end

module AttrInit
end
