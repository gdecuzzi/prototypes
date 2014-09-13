require 'rspec'
require_relative '../src/prototyped_object'

describe 'Add Property' do

  it 'agregar una propiedad entiende el getter' do
    guerrero = PrototypedObject.new
    guerrero.set_property(:energia, 100)
    expect(guerrero.respond_to? :energia).to eq true
  end

  it 'agregar una propiedad con valor la inicializa' do
    guerrero = PrototypedObject.new
    guerrero.set_property(:energia, 100)
    expect(guerrero.energia).to eq(100)
  end

  it 'agregar una propiedad entiende el setter' do
    guerrero = PrototypedObject.new
    guerrero.set_property(:energia, 100)
    expect {guerrero.energia=50}.to_not raise_error
  end

  it 'agregar una propiedad cambia su valor despues del setter' do
    guerrero = PrototypedObject.new
    guerrero.set_property(:energia, 100)
    guerrero.energia=50
    expect(guerrero.energia).to eq(50)
  end

  it 'agregar una propiedad solo la agrega a ese prototipo' do
    conPropiedad = PrototypedObject.new
    conPropiedad.set_property :energia, 10
    expect(conPropiedad.respond_to? :energia).to eq true

    sinPropiedad = PrototypedObject.new
    expect(sinPropiedad.respond_to? :energia).to eq false
  end

end