Feature: Multi-methods

  Scenario Outline: simple one path
    Given the following code
    """
      class HelloWorldReturner
        include MultiMethods
        
        multi_method :hello_world do
          router {|*args| :the_path}
          implementation_for :the_path do |*args|
            "<expected_return_value>"
          end
        end
      end
    """
    When I run
    """
      p = HelloWorldReturner.new
      p.hello_world
    """
    Then the return should be "<expected_return_value>"

    Examples:
    |expected_return_value|
    |you worked|
    |another value|
    
    Scenario: two paths
      Given the following code
      """
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
      """
      When I run
      """
        p = PathMan.new
        p.route_me true
      """
      Then the return should be "you called path one"
      
      When I run
      """
        p = PathMan.new
        p.route_me false
      """
      Then the return should be "you called path two"

       Scenario: working with parameters
          Given the following code
          """
            class Summer
              include MultiMethods

              multi_method :sum do
                router {|*args| :add_them}
                implementation_for :add_them do |*args|
                  args.inject(0) {|accum,num|accum+num}
                end
              end
            end
          """
          When I run
          """
            p = Summer.new
            p.sum 1, 2, 3, 4
          """
          Then the return should be "10"
