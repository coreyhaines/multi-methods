require File.expand_path(File.dirname(__FILE__) + '/spec_helper')



describe MultiMethods do
  before(:each) do
    @class = Class.new
    @class.send :include, MultiMethods
  end
  context "calling the created method" do
    before(:each) do
      @class.multi_method :hello_world do
        router {|*args| :the_path}
        implementation_for :the_path do
          'hello, world'
        end
      end
      @instance = @class.new
    end
    it "returns the value" do
      @instance.hello_world.should == "hello, world"
    end
  end
  
  context "routing to different implementation" do
    before(:each) do
      @class.multi_method :route_me do
        router {|*args| args[0]}
        implementation_for :path_one do |*args|
          "you called path one"
        end
        implementation_for :path_two do |*args|
          "you called path two"
        end
      end
      @instance = @class.new
    end
    
    it "routes to first path" do
      @instance.route_me(:path_one).should == "you called path one"
    end
    it "routes to second path" do
      @instance.route_me(:path_two).should == "you called path two"
    end
    it "returns nil if no matching dispatch value" do
      @instance.route_me(:no_path).should be_nil
    end
  end
  
  context "working with parameters" do
    before(:each) do
      @class.multi_method :return_parameters do
        router {|*args| :path}
        implementation_for :path do |*args|
          args
        end
      end
      @instance = @class.new
    end
    it "gets parameters passed to it" do
      @instance.return_parameters(2, 3, 4).should == [2,3,4]
    end
  end
  
  context "adding new dispatching" do
    before(:each) do
      @class.multi_method :add_to_me do
        router {|*args| args[0]}
        implementation_for :existing do |*args|
          :existing_method
        end
      end
      @instance = @class.new
    end
    it "routes to the added implementation" do
      @class.multi_method :add_to_me do
        implementation_for :added do |*args|
          :added
        end
      end
      @instance.add_to_me(:added).should == :added
    end
  end
end
