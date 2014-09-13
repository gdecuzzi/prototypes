class PrototypedObject

  def set_property(name, value)
    self.singleton_class.send :attr_accessor, name
    self.send "#{name}=", value
  end

  def set_method(selector, code)
   self.singleton_class.send :define_method, selector, code
  end

  def set_prototype(aPrototype)
    #self.class.superclass = aPrototype.class
  end

  end