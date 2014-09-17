module Prototyped
  def initialize
    @allBehavior = Hash.new
    super
  end

  def set_property(name, value)
    self.singleton_class.send :attr_accessor, name
    self.send "#{name}=", value
  end

  def set_method(selector, code)
    self.singleton_class.send :define_method, selector, code
    @allBehavior.store selector, code
  end

  def set_prototype(aPrototype)
    @parent = aPrototype
  end

  def respond_to_missing?(method_name, include_private = true)
    (@parent != nil && (@parent.respond_to? method_name)) || (super method_name, include_private)
  end

  def method_missing(selector, *arguments, &block)
    if(@parent == nil || @parent.method(selector) == nil)
      return super.method_missing selector, arguments #FIXME tirar el DNU de ruby
    end
    #uggly... i would love something like:
    #myMethod = @parent.singleton_class.instance_method selector
    #myMethod.bind(self)
    #myMethod.call *arguments
    #but: TypeError: singleton method called for a different object
    
    code = @parent.obtain_proc selector
    if code != nil
      self.instance_exec(*arguments, &code)
    else #houston we have a property accesses
      create_parent_property selector, !arguments.empty?
      self.send selector, *arguments
    end
  end

  def obtain_proc(selector)
    @allBehavior[selector]
  end

  def create_parent_property (selector, isSetter)
    name = selector
    if isSetter
      name = selector.to_s[0...-1] #uggly... but i need to remove the = if is a setter
    end

    self.set_property name, nil
  end


end

class PrototypedObject
  include Prototyped


end