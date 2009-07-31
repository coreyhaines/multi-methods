Feature: Multi-methods

  Scenario: simple hello, world, one path
    Given the following code
    """
      class HelloWorldReturner
        include MultiMethods
        
        multi_method :hello_world do
          router {|*args| :hello_world}
          implementation_for :hello_world do
            'you worked'
          end
        end
      end
    """
    When I run
    """
      p = HelloWorldReturner.new
      p.hello_world
    """
    Then the return should be "you worked"
