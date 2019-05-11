require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
     test "must create a Comment when content is provided" do
      comment = comments(:one)
      assert_equal(true, comment.save, "must create a Comment when content is provided")
     end
     
     
end
