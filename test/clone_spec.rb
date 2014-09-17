require 'rspec'
require_relative '../src/prototyped_object'

describe 'Clone object' do

  it 'clonado toma el valor de la property del original' do
    original = PrototypedObject.new
    original.set_property :any, 42

    copy = original.clone
    expect(copy.any).to eq 42
  end

  it 'clonado y original no comparten estado para la property' do
    original = PrototypedObject.new
    original.set_property :any, 42

    copy = original.clone
    copy.any=100
    expect(copy.any).to eq 100
    expect(original.any).to eq 42
  end

  it 'should clonado entiende los mensajes del original' do
    original = PrototypedObject.new
    original.set_method :holo, proc { 'Es hola sr!' }

    copy = original.clone

    expect(copy.respond_to? :holo).to eq true
    expect(copy.holo).to eq 'Es hola sr!'
  end

  it 'clonado no entiende los mensajes del original agregados despues' do
    original = PrototypedObject.new
    original.set_method :holo, proc { 'Es hola sr!' }

    copy = original.clone

    original.set_method :mostruosidad, proc { 'Metrossity' }

    expect(copy.respond_to? :mostruosidad).to eq false
  end
end