require 'rspec'
require_relative "../src/prototyped_object"

describe 'Add Method' do

  it 'Agregar metodo sin variables hace que el objeto entienda el mensaje' do
    object = PrototypedObject.new
    object.set_method(:secretOfLife, proc {42})
    expect(object.respond_to? :secretOfLife).to eq true
  end

  it 'Agregar metodo hace que el haga lo que deberia' do
    object = PrototypedObject.new
    object.set_method(:secretOfLife, proc {42})
    expect(object.secretOfLife).to eq 42
  end

  it 'Agregar metodo con parametros hace que el objeto lo entienda' do
    object = PrototypedObject.new
    object.set_method(:bestMatchFor, proc { |number| 42-number})
    expect{object.bestMatchFor(20)}.to_not raise_error
  end

  it 'Agregar metodo con parametros hace lo que deberia' do
    object = PrototypedObject.new
    object.set_method(:bestMatchFor, proc { |number| 42-number})
    expect(object.bestMatchFor(20)).to eq 22
  end

  it 'agregar mensaje complejo lo entiende' do
    guerrero = PrototypedObject.new
    guerrero.set_property(:energia, 100)
    expect(guerrero.energia).to eq(100)

    guerrero.set_property(:potencial_defensivo, 10)
    guerrero.set_property(:potencial_ofensivo, 30)
    guerrero.set_method(:atacar_a,
                        proc {
                            |otro_guerrero|
                          if(otro_guerrero.potencial_defensivo < self.potencial_ofensivo)
                            otro_guerrero.recibe_danio(self.potencial_ofensivo - otro_guerrero.potencial_defensivo)
                          end
                        })
    expect(guerrero.respond_to? :atacar_a).to eq true
  end

end