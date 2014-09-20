class PrototypedConstructor

  def nuevo_constructor *args
    if(args.size == 2)
      constructor = ConstructorWithInitializations.new
      constructor.prototype = args[0]
      constructor.initializations = args[1]
      constructor
    else
      constructor = ConstructorOnlyPrototype.new
      constructor.prototype = args[0]
      constructor
    end
  end



end

class ConstructorWithInitializations
  attr_accessor :prototype
  attr_accessor :initializations

  def new *args
    instance = prototype.clone

    params = []
    params << instance
    params = params.concat args

    instance.instance_exec *params, &initializations
    instance
  end
end

class ConstructorOnlyPrototype
  attr_accessor :prototype

  def new initializations
    instance = prototype.clone
    initializations.each { |key, value|
      instance.send "#{key}=", value
    }
    instance
  end
end