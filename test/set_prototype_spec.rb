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
end