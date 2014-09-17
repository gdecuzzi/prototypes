class PrototypedObject
  def initialize
    @allBehavior = Hash.new
    @variables = Array.new
    super
  end

  def set_property(name, value)
    @variables << name

    self.singleton_class.send :attr_accessor, name
    self.send "#{name}=", value
  end

  def set_method(selector, code)
    self.singleton_class.send :define_method, selector, code

    @allBehavior.store selector, code
  end

  def variables()
    @variables
  end

  def set_prototype(aPrototype)
    @parent = aPrototype

  end

  def method_missing(selector, *arguments, &block)
    if(@parent == nil || @parent.method(selector) == nil)
      return super.method_missing selector, arguments
    end

    @code = @parent.obtain_proc selector
    if(@code != nil)
      self.instance_eval &@code
    else #esto pasaria porque el selector es de una property
      if arguments.empty?
        self.set_property selector, nil
      else
        name = selector.to_s[0...-1]
        self.set_property name, nil
      end
      self.send selector, *arguments

    end
  end

  def respond_to_missing?(method_name, include_private = false)
    (@parent != nil && (@parent.respond_to? method_name)) || (super method_name, include_private)
  end

  def obtain_proc(selector)
    @allBehavior[selector]
  end

end