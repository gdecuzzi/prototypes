class PrototypedConstructor

  def self.new *args
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

  def self.copy(original)
    constructor = ConstructorAsCopy.new
    constructor.prototype = original
    constructor
  end


end

class ConstructorWithInitializations
  attr_accessor :prototype
  attr_accessor :initializations

  def new *args
    instance = PrototypedObject.new
    instance.set_prototype prototype

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
    instance = PrototypedObject.new
    instance.set_prototype prototype

    initializations.each { |key, value|
      instance.send "#{key}=", value
    }
    instance
  end
end

class ConstructorAsCopy
  attr_accessor :prototype

  def new
    instance = PrototypedObject.new
    instance.set_prototype prototype
    instance
  end
end