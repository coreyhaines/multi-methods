module MultiMethods
  def self.included(base)
    base.extend ClassMethods
  end
  module ClassMethods
    def multi_method name, &block
      define_method name do |*args|
        MultiMethod.call(*args, &block)
      end
    end
  end
  
  
  class MultiMethod
    def self.call(*args, &block)
      @dispatcher = MultiMethod.get_multimethod(&block)
      @dispatcher.execute(*args)
    end



    class Dispatcher
      attr_accessor :methods
      attr_accessor :router_method
      def initialize
        @methods = Hash.new(Proc.new {})
      end
      def router &block
        @router_method = block
      end
      def implementation_for symbol, &block
        @methods[symbol] = block
      end
      def code_for dispatching_value
        @methods[dispatching_value]
      end
    
      def execute(*args)
        dispatching_value = router_method.call(*args)
        proc = code_for dispatching_value
        proc.call(*args)
      end
    end
private
    def self.get_multimethod &block
      implementation = Dispatcher.new
      implementation.instance_eval(&block)
      implementation
    end
  end
end