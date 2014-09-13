require 'rspec'
require_relative "../src/prototyped_object"

describe 'Add Method' do

  it 'Agregar metodo sin variables hace que el objeto entienda el mensaje' do
    object = PrototypedObject.new
    object.set_method(:secretOfLife, proc {42})
    expect{object.secretOfLife}.to_not raise_error
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

end