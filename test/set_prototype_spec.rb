require 'rspec'
require_relative '../src/prototyped_object'

describe 'Define prototype for an object' do

  it 'definir proptotipo a un objeto hace que entienda el mensaje del otro' do
    parent = PrototypedObject.new
    parent.set_method :secret_of_life, proc{42}

    child = PrototypedObject.new
    child.set_prototype parent

    expect(child.respond_to? :secret_of_life).to eq true
    expect(child.secret_of_life).to eq 42
  end
end