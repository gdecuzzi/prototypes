class PrototypedConstructor

  def nuevo_constructor(prototype, initializations)
    constructor = new_class_constuctor
    constructor.prototype = prototype
    constructor.initializations = initializations
    constructor
  end

  def new_class_constuctor
    Constructor.new
  end

end

class Constructor
  attr_accessor :prototype
  attr_accessor :initializations

  def nuevo_objeto *args
    instance = prototype.clone

    params = []
    params << instance
    params = params.concat args

    instance.instance_exec *params, &initializations
    instance
  end


end