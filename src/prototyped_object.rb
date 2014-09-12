class PrototypedObject

  def set_property(name, value)
    self.class.send :attr_accessor, name
    self.send "#{name}=", value
  end

  end