require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
   test "invite" do
    # Create the email and store it for further assertions
    email = UserMailer.send_welcome_email(users(:one))
 
    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end
 
    # Test the body of the sent email contains what we expect it to
    assert_equal ['test@example.com'], email.from
    assert_equal ['test@example.com'], email.to
    assert_equal 'Welcome to Social Trip App', email.subject
  end
end
