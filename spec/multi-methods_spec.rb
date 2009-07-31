require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


class HelloWorldReturner
  include MultiMethods
  
  multi_method :hello_world do
    router {|*args| :hello_world}
    implementation_for :hello_world do
      'you worked'
    end
  end
end

class HelloWorldReturner2
  include MultiMethods
  
  multi_method :hello_world do
    router {|*args| :hello_world}
    implementation_for :hello_world do
      'another return'
    end
  end
end

describe MultiMethods do
  context "calling the created method" do
    it "returns the appropriate value" do
      HelloWorldReturner.new.hello_world.should == "you worked"
      HelloWorldReturner2.new.hello_world.should == "another return"
    end
  end
end
