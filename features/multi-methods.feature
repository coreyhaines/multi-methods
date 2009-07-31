Feature: Multi-methods

  Scenario Outline: simple one path
    Given the following code
    """
      class HelloWorldReturner
        include MultiMethods
        
        multi_method :hello_world do
          router {|*args| :hello_world}
          implementation_for :hello_world do
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