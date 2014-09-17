module Prototyped
  def initialize
    @all_behavior = Hash.new

  end

  def set_property(name, value)
    self.singleton_class.send :attr_accessor, name
    self.send "#{name}=", value
  end

  def set_method(selector, code)
    self.singleton_class.send :define_method, selector, code
    @all_behavior.store selector, code
  end

  def set_prototype(a_prototype)
    @parent = a_prototype
  end

  def respond_to_missing?(method_name, include_private = true)
    (@parent != nil && (@parent.respond_to? method_name)) || (super method_name, include_private)
  end

  def method_missing(selector, *arguments, &block)
    if @parent == nil || @parent.method(selector) == nil
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
    else #houston we have a property access
      create_parent_property selector, !arguments.empty?
      self.send selector, *arguments
    end
  end

  def obtain_proc(selector)
    @all_behavior[selector]
  end

  def create_parent_property (selector, is_setter)
    name = selector
    if is_setter
      name = selector.to_s[0...-1] #uggly... but i need to remove the = if is a setter
    end

    self.set_property name, nil
  end
end

class PrototypedObject
  include Prototyped


end