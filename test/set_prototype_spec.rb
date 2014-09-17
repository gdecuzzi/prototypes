require 'rspec'
require_relative '../src/prototyped_object'

describe 'Define prototype for an object' do

  it 'definir proptotipo a un objeto hace que entienda el mensaje del otro' do
    parent = PrototypedObject.new
    parent.set_method :secret_of_life, proc{42}

    child = PrototypedObject.new
    child.set_prototype parent

    expect(parent.respond_to? :secret_of_life).to eq true
    expect(child.respond_to? :secret_of_life).to eq true
    expect(child.secret_of_life).to eq 42
  end

  it 'sin prototipo ni mensaje definido no lo entiende' do
    parent = PrototypedObject.new
    parent.set_method :secret_of_life, proc{42}

    expect(parent.respond_to? :no_definido).to eq false
    expect{parent.no_definido}.to raise_exception
  end

  it 'definir proptotipo a un objeto con propiedad hace que entienda el getter' do
    parent = PrototypedObject.new
    parent.set_property :energia,20

    child = PrototypedObject.new
    child.set_prototype parent

    expect(child.respond_to? :energia).to eq true
    expect(child.energia).to eq nil
  end


  it 'definir proptotipo a un objeto con propiedad hace que entienda el setter' do
    parent = PrototypedObject.new
    parent.set_property :energia,20

    child = PrototypedObject.new
    child.set_prototype parent
    child.energia = 100

    expect(child.energia).to eq 100
  end


  it 'settear valor de propiedad al child no altera al valor del parent' do
    parent = PrototypedObject.new
    parent.set_property :energia,20

    child = PrototypedObject.new
    child.set_prototype parent
    child.energia = 100

    expect(child.energia).to eq 100
    expect(parent.energia).to eq 20
  end

  it 'settear valor de propiedad al child mantiene al estado' do
    parent = PrototypedObject.new
    parent.set_property :energia,20

    child = PrototypedObject.new
    child.set_prototype parent
    child.energia = 100
    child.energia = child.energia + 10

    expect(child.energia).to eq 110
    expect(parent.energia).to eq 20
  end

  it 'usar la propiedad dentro de un metodo del child altera el estado del child' do
    parent = PrototypedObject.new
    parent.set_property :energia,20

    child = PrototypedObject.new
    child.set_prototype parent
    child.energia= 100
    child.set_method :vola, proc{ self.energia= self.energia - 10}
    child.vola

    expect(child.energia).to eq 90
    expect(parent.energia).to eq 20
  end

  it 'enviar mensaje con parametros que viene de un parent envia los parametros' do
    parent = PrototypedObject.new
    parent.set_method :expecting_param, proc { |should_not_be_nil|
      if should_not_be_nil == nil
        raise_exception 'Should not be nil'
      end
      should_not_be_nil
    }
    child = PrototypedObject.new
    child.set_prototype parent

    expect(child.expecting_param 'Success').to eq 'Success'
  end

  it 'ejemplo del enunciado funcina' do
    guerrero = PrototypedObject.new
    guerrero.set_property :energia, 100
    guerrero.set_property :potencial_defensivo, 10
    guerrero.set_property :potencial_ofensivo, 30
    guerrero.set_method(:atacar_a,
                      proc {
                          |otro_guerrero|
                        if(otro_guerrero.potencial_defensivo < self.potencial_ofensivo)
                          otro_guerrero.recibe_danio(self.potencial_ofensivo - otro_guerrero.potencial_defensivo)
                        end
                      })
    guerrero.set_method(:recibe_danio, proc {|cantidad| self.energia = self.energia - cantidad})
    espadachin = PrototypedObject.new
    espadachin.set_prototype(guerrero)

    espadachin.set_property(:habilidad, 0.5)
    espadachin.set_property(:potencial_espada, 30)
    espadachin.energia = 200
    espadachin.potencial_ofensivo=30

    espadachin.atacar_a(guerrero)
    expect(guerrero.energia).to eq(80)
  end

  it 'agregar mensaje al parent hace que lo entienda el child' do
    parent = PrototypedObject.new
    parent.set_method :secret_of_life, proc{42}

    child = PrototypedObject.new
    child.set_prototype parent

    parent.set_method :one_more, proc{43}

    expect(child.respond_to? :one_more).to eq true
    expect(child.one_more).to eq 43
  end

  it 'si el child redefine el mensaje del parent se pefiere el del child' do
    parent = PrototypedObject.new
    parent.set_method :secret_of_life, proc{42}

    child = PrototypedObject.new
    child.set_prototype parent

    parent.set_method :secret_of_life, proc{1000}

    expect(child.secret_of_life).to eq 1000
  end


end