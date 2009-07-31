module MultiMethods
  def self.included(base)
    base.extend ClassMethods
  end
  
  class ImplementationCapture
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
      implementation = ImplementationCapture.new
      implementation.instance_eval(&block)
      define_method name do |*args|
        desired_route = implementation.router_method.call(*args)
        proc = implementation.methods[desired_route] || Proc.new {}
        proc.call(*args)
      end
    end
  end
  
end