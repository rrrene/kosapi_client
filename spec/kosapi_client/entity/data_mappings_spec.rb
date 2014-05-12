require 'spec_helper'

describe KOSapiClient::Entity::DataMappings do

  let(:dummy_class) { Class.new { include KOSapiClient::Entity::DataMappings } }
  let(:dummy_instance) { dummy_class.new }

  it 'defines .parse class method' do
    expect(dummy_class).to respond_to(:parse)
  end

  it 'defines .map_data class method' do
    expect(dummy_class).to respond_to(:map_data)
  end

  describe '.parse' do

    it 'parses simple hash structure' do
      dummy_class.map_data :foo
      parsed = dummy_class.parse({foo: 'bar'})
      expect(parsed).to be_an_instance_of(dummy_class)
      expect(parsed.foo).to eq 'bar'
    end

    it 'parses integer type' do
      dummy_class.map_data :foo, Integer
      parsed = dummy_class.parse({foo: '1'})
      expect(parsed.foo).to eq 1
    end

    it 'parses array of types' do
      dummy_class.map_data :foo, [Integer]
      parsed = dummy_class.parse({foo: %w(5 7 11)})
      expect(parsed.foo).to eq [5, 7, 11]
    end

    it 'parses custom types' do
      dummy_class.map_data :foo, KOSapiClient::Entity::Enum
      parsed = dummy_class.parse({foo: 'bar'})
      expect(parsed.foo).to eq :bar
    end

  end

end