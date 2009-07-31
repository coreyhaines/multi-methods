require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


class Foo
  include MultiMethods
  
  multi_method :bar do
  end
end

class HelloWorldReturner
  include MultiMethods
  
  multi_method :hello_world do
    router {|*args| :hello_world}
    implementation_for :hello_world do
      'you worked'
    end
  end
end

describe MultiMethods do

  context "getting it compiling" do
    it "allows me to include and call on a class" do
      Foo.new
    end
  end
  
  context "calling the created method" do
    it "has the method" do
      Foo.new.bar
    end
    it "returns the appropriate value" do
      HelloWorldReturner.new.hello_world.should == "you worked"
    end
  end
  
  
end
