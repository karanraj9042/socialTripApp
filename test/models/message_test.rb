require 'test_helper'

class MessageTest < ActiveSupport::TestCase
      
      
      test "must not create a Message when title is not provided" do
       message = messages(:one)
       assert_equal(false, message.save, "must not create a Message when title is not provided")
      end
     
      test "must not create a Message when description is not provided" do
       message = messages(:two)
       assert_equal(false, message.save, "must not create a Message when description is not provided")
      end
      
     
end
