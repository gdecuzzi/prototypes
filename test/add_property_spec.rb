require 'rspec'
require_relative '../src/prototyped_object'

describe 'Add Property' do

  it 'agregar una propiedad entiende el getter' do
    guerrero = PrototypedObject.new
    guerrero.set_property(:energia, 100)
    guerrero.energia
  end

  it 'agregar una propiedad con valor la inicializa' do
    guerrero = PrototypedObject.new
    guerrero.set_property(:energia, 100)
    expect(guerrero.energia).to eq(100)
  end

  it 'agregar una propiedad entiende el setter' do
    guerrero = PrototypedObject.new
    guerrero.set_property(:energia, 100)
    guerrero.energia=50
  end

  it 'agregar una propiedad cambia su valor despues del setter' do
    guerrero = PrototypedObject.new
    guerrero.set_property(:energia, 100)
    guerrero.energia=50
    expect(guerrero.energia).to eq(50)
  end



end