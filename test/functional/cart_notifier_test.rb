require 'test_helper'

class CartNotifierTest < ActionMailer::TestCase
  test "error" do
  	cart = carts(:one)
    mail = CartNotifier.error("Undefined cart accessing error #{cart.id}")
    assert_equal "Error", mail.subject
    assert_equal ["cheeerny@rambler.ru"], mail.to
    assert_equal ["admin@application.com"], mail.from
    assert_match "Undefined cart accessing error #{cart.id}", mail.body.encoded
  end

end
