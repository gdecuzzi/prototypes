class PrototypedObject

  def set_property(name, value)
    self.class.send :attr_accessor, name
    self.send "#{name}=", value
  end

  def set_method(selector, code)
   self.class.send :define_method, selector, code
  end

  end