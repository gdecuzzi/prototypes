class PrototypedObject
  def initialize
    @allBehavior = Hash.new
    super
  end

  def set_property(name, value)
    self.singleton_class.send :attr_accessor, name
    self.send "#{name}=", value

    @allBehavior.store name, proc { eval("@#{name}")}



  end

  def set_method(selector, code)
    self.singleton_class.send :define_method, selector, code

    @allBehavior.store selector, code
  end

  def set_prototype(aPrototype)
    @parent = aPrototype
  end

  def method_missing(selector, *arguments, &block)
    if(@parent == nil?)
      return super.method_missing selector, arguments
    end

    @code = @parent.obtain_proc selector
    if(@code == nil)
      return super.method_missing selector, arguments
    end

    self.instance_eval &@code


  end

  def respond_to_missing?(method_name, include_private = false)
    (@parent != nil && (@parent.respond_to? method_name))|| (super method_name, include_private)
  end

  def obtain_proc(selector)
    @allBehavior[selector]
  end

end