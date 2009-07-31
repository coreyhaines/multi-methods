require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


class HelloWorldReturner
  include MultiMethods
  
  multi_method :hello_world do
    router {|*args| :the_path}
    implementation_for :the_path do
      'you worked'
    end
  end
end

class HelloWorldReturner2
  include MultiMethods
  
  multi_method :hello_world do
    router {|*args| :the_path}
    implementation_for :the_path do
      'another return'
    end
  end
end

 class PathMan
    include MultiMethods

    multi_method :route_me do
      router {|*args| args[0] == true ? :path_one : :path_two}
      implementation_for :path_one do |*args|
        "you called path one"
      end
      implementation_for :path_two do |*args|
        "you called path two"
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
  
  context "routing" do
    it "routes me to the appropriate implementation" do
      p = PathMan.new
      p.route_me(true).should == "you called path one"
      p.route_me(false).should == "you called path two"
    end
  end
end
