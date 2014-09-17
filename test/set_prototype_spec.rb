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


end