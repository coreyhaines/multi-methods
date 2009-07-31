module MultiMethods
  def self.included(base)
    base.extend ClassMethods
  end
  module ClassMethods
    def multi_method name, &block
      dispatcher = dispatcher_for name, &block
      define_method name do |*args|
        dispatcher.execute(*args)
      end
    end
    def dispatchers
      @dispatchers ||= {}
    end
    def dispatcher_for name, &block
      unless dispatchers[name]
        dispatchers[name] = MultiMethod::Dispatcher.new
      end
      dispatchers[name].instance_eval &block
      dispatchers[name]
    end
  end
  
  
  class MultiMethod
    def self.call(*args, &block)
      create_dispatcher(&block).execute(*args)
    end
    def self.create_dispatcher &block
      dispatcher = Dispatcher.new
      dispatcher.instance_eval(&block)
      dispatcher
    end

    class Dispatcher
      def initialize
        @implementations = Hash.new(Proc.new {})
      end
      def router &block
        @dispatching_method = block
      end
      def implementation_for symbol, &block
        @implementations[symbol] = block
      end

      def execute(*args)
        dispatching_value = @dispatching_method.call(*args)
        proc = code_for dispatching_value
        proc.call(*args)
      end
      
private
      def code_for dispatching_value
        @implementations[dispatching_value]
      end
    end
  end
end