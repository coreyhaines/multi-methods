module MultiMethods
  def self.included(base)
    base.extend ClassMethods
  end
  
  class MultiMethod
    def self.get_multimethod &block
      implementation = MultiMethod.new
      implementation.instance_eval(&block)
      implementation
    end

    def execute(*args)
      desired_route = router_method.call(*args)
      proc = methods[desired_route] || Proc.new {}
      proc.call(*args)
    end

    def self.call(*args, &block)
      implementation = MultiMethod.get_multimethod(&block)
      implementation.execute(*args)
    end

    attr_accessor :methods
    attr_accessor :router_method
    def initialize
      @methods = {}
    end
    def router &block
      @router_method = block
    end
    def implementation_for symbol, &block
      @methods[symbol] = block
    end
  end
  
  module ClassMethods
    def multi_method name, &block
      define_method name do |*args|
        MultiMethod.call(*args, &block)
      end
    end
  end
  
end