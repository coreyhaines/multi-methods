module MultiMethods
  def self.included(base)
    base.extend ClassMethods
  end
  
  class ImplementationCapture
    attr_accessor :methods
    def initialize
      @methods = {}
    end
    def router
      
    end
    def implementation_for symbol, &block
      @methods[symbol] = block
    end
  end
  
  module ClassMethods
    def multi_method name, &block
      implementation = ImplementationCapture.new
      implementation.instance_eval(&block)
      define_method name, implementation.methods[:hello_world]
    end
  end
  
end