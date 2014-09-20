require 'rspec'
require_relative '../src/protoyped_constructor'
require_relative '../src/prototyped_object'

describe 'Crear un prototipo con vitaminas' do

  it 'crear un proto_prototipo genera una clase con un constructor no default' do
    guerrero = PrototypedObject.new
    guerrero.set_property :energia, 100
    guerrero.set_property :potencial_ofensivo, 10
    guerrero.set_property :potencial_defensivo, 30

    Guerrero = PrototypedConstructor.new.nuevo_constructor(guerrero, proc {
      |guerrero_nuevo, una_energia, un_potencial_ofensivo, un_potencial_defensivo|
      guerrero_nuevo.energia = una_energia
      guerrero_nuevo.potencial_ofensivo = un_potencial_ofensivo
      guerrero_nuevo.potencial_defensivo = un_potencial_defensivo})

    un_guerrero = Guerrero.nuevo_objeto(100, 30, 10)
    expect(un_guerrero.energia).to eq(100)
  end

  
end