
class PrototypedObject

  def set_property(name, value)
    self.singleton_class.send :attr_accessor, name
    self.send "#{name}=", value
  end

  def set_method(selector, code)
    self.singleton_class.send :define_method, selector, code
  end

  def set_prototype(aPrototype)
    @parent = aPrototype
  end

  def method_missing(selector, *arguments, &block)
    if(@parent != nil?)
      if(arguments.empty?)
        eval("@parent.#{selector}", binding)
      else
        @arg = arguments[0]
        eval("@parent.#{selector} #{@arg}", binding)
      end


    else
      super.method_missing selector, arguments
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    (@parent != nil && (@parent.respond_to? method_name))|| (super method_name, include_private)
  end

end