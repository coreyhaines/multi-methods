require File.expand_path(File.dirname(__FILE__) + '/spec_helper')



describe MultiMethods do
  before(:each) do
    @o = Class.new
    @o.send :include, MultiMethods
  end
  context "calling the created method" do
    before(:each) do
      @o.multi_method :hello_world do
        router {|*args| :the_path}
        implementation_for :the_path do
          'hello, world'
        end
      end
      @instance = @o.new
    end
    it "returns the value" do
      @instance.hello_world.should == "hello, world"
    end
  end
  
  context "routing to different implementation" do
    before(:each) do
      @o.multi_method :route_me do
        router {|*args| args[0] == true ? :path_one : :path_two}
        implementation_for :path_one do |*args|
          "you called path one"
        end
        implementation_for :path_two do |*args|
          "you called path two"
        end
      end
      @instance = @o.new
    end
    
    it "routes to first path" do
      @instance.route_me(true).should == "you called path one"
    end
    it "routes to second path" do
      @instance.route_me(false).should == "you called path two"
    end
  end
  
  context "working with parameters" do
    before(:each) do
      @o.multi_method :return_parameters do
        router {|*args| :path}
        implementation_for :path do |*args|
          args
        end
      end
      @instance = @o.new
    end
    it "gets parameters passed to it" do
      @instance.return_parameters(2, 3, 4).should == [2,3,4]
    end
  end
end
