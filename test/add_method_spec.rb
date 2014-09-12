require 'rspec'
require_relative "../src/prototyped_object"

describe 'Add Method' do

  it 'Agregar metodo lo agrega en el objeto' do
    object = PrototypedObject.new
    object.set_method(:estaLejos,proc {true})
    expect(object.estaLejos).to true
  end
end