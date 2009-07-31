module MultiMethods
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def multi_method name, &block
      define_method name do
        "you worked"
      end
    end
  end
  
end