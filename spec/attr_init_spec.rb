require 'attr_init'
require 'spec_helper'

describe AttrInit do
  let(:symbols) do
    [:a, :b, :c]
  end

  let(:hash_params) do
    Hash[symbols.each_with_index.to_a]
  end

  let(:reader_struct) do
    class Foo
      reader_struct :a, :b, :c
    end
    Foo
  end

  let(:accessor_struct) do
    class Bar
      accessor_struct :a, :b, :c
    end
    Bar
  end

  describe '::new' do
    it 'allows super class' do
      class A
        reader_struct :a
      end

      class B < A
        reader_struct :b
        def initialize(params)
          super
          attr_init(params)
        end
      end

      object = B.new(a: 0, b: 1)

      expect(object.b).to eq 1
      expect(object.a).to eq 0
    end

    it 'defines #to_h' do
      object = reader_struct.new(hash_params)

      expect(object.to_h).to eq hash_params
    end

    context 'reader_struct' do
      it 'initializes readers with hash initializer' do
        object = reader_struct.new(hash_params)

        expect(object.a).to eq 0
        expect(object.b).to eq 1
        expect(object.c).to eq 2

        expect { object.a = 3 }.to raise_error
      end
    end

    context 'accessor_struct' do
      it 'initializes accessor with hash initializer' do
        object = accessor_struct.new(hash_params)

        expect(object.a).to eq 0
        expect(object.b).to eq 1
        expect(object.c).to eq 2

        object.a = 'hello'

        expect(object.a).to eq 'hello'
      end
    end
  end
end
