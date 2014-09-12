class PrototypedObject

  def set_property(name, value)
    self.class.send :attr_accessor, name
    self.send "#{name}=", value
  end

  def set_method(selector, code)
   self.class.define_method selector do code end
  end

  end