require 'rspec'
require_relative '../src/protoyped_constructor'
require_relative '../src/prototyped_object'

describe 'Crear un prototipo con vitaminas' do

  it 'se puede crear un protoyipo pasandole el prototipo y la inicializacion' do
    guerrero = PrototypedObject.new
    guerrero.set_property :energia, 100
    guerrero.set_property :potencial_ofensivo, 10
    guerrero.set_property :potencial_defensivo, 30

    Guerrero = PrototypedConstructor.new(guerrero, proc {
      |guerrero_nuevo, una_energia, un_potencial_ofensivo, un_potencial_defensivo|
      guerrero_nuevo.energia = una_energia
      guerrero_nuevo.potencial_ofensivo = un_potencial_ofensivo
      guerrero_nuevo.potencial_defensivo = un_potencial_defensivo})

    un_guerrero = Guerrero.new(100, 30, 10)
    expect(un_guerrero.energia).to eq(100)
  end

  it 'se puede crear un protoipo pasandole el prototipo e inicializaciones despues' do
    guerrero = PrototypedObject.new
    guerrero.set_property :energia, 100
    guerrero.set_property :potencial_ofensivo, 10
    guerrero.set_property :potencial_defensivo, 30

    Guerrero = PrototypedConstructor.new(guerrero)
    un_guerrero = Guerrero.new(
        {energia: 100, potencial_ofensivo: 30, potencial_defensivo: 10}
    )
    expect(un_guerrero.potencial_ofensivo).to eq(30)
  end

  it 'se puede crear un prototipo copiando el estado del original' do
    guerrero = PrototypedObject.new
    guerrero.set_property :energia, 100
    guerrero.set_property :potencial_ofensivo, 10
    guerrero.set_property :potencial_defensivo, 30

    Guerrero = PrototypedConstructor.copy(guerrero)
    un_guerrero = Guerrero.new
    expect(un_guerrero.potencial_defensivo).to eq(30)
    expect(un_guerrero.potencial_ofensivo).to eq(10)
    expect(un_guerrero.energia).to eq(100)
  end

end