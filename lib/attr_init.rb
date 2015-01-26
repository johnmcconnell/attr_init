require "attr_init/version"
require 'fattr'
require 'set'

def attr_init(*attrs)
  AttrInit.add_new_attrs(self, attrs)

  define_method(:attr_init) do |params|
    AttrInit.get_attrs(self.class).each do |a|
      instance_variable_set "@#{a}", params[a]
    end
  end

  protected :attr_init

  define_method(:initialize) do |params|
    attr_init(params)
  end
end

def fattr_init(*attrs)
  class_eval do
    def initialize(params)
      fattr_init(params)
    end

    protected

    def fattr_init(params)
      params.each do |key, value|
        send key, value
      end
    end
  end
end

def fattr_hash(*attrs)
  class_eval do
    self.class.fattrs.each_with_object({}) do |key, hash|
      hash[key] = send key
    end
  end
end

def attr_hash(*attrs)
  define_method(:to_h) do
    AttrInit.get_attrs(self.class).each_with_object({}) do |attr, hash|
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
  fattrs *attrs
  fattr_init *attrs
  fattr_hash *attrs
end

module AttrInit
  def self.add_new_attrs(scope, attrs)
    begin
      hidden_attrs = get_attrs(scope.superclass)
      scope.class_variable_set hidden_attrs_variable_name, hidden_attrs + attrs
    rescue NameError => e
      scope.class_variable_set hidden_attrs_variable_name, Set.new(attrs)
    end
  end

  def self.get_attrs(scope)
    scope.class_variable_get hidden_attrs_variable_name
  end

  def self.hidden_attrs_variable_name
    :@@_hidden_attrs
  end
end
