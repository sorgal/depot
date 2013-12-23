require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
	assert_equal "Order recieving Pragmatic Store", mail.subject
	assert_equal ["dave@example.org"], mail.to
	assert_equal ["admin@application.com"], mail.from
	assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
	assert_equal "Order from Pragmatic Store sended", mail.subject
	assert_equal ["dave@example.org"], mail.to
	assert_equal ["admin@application.com"], mail.from
	assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end

end
