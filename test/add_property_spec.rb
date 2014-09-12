require 'rspec'
require_relative '../src/prototyped_object'

describe 'Add Property' do

  it 'agregar una propiedad la inicializa y entiende el getter' do
    guerrero = PrototypedObject.new
    guerrero.set_property(:energia, 100)
    expect(guerrero.energia).to eq(100)
  end

end