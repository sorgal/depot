require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
	fixtures :products
	# A user goes to the index page. They select a product, adding it to their
	# cart, and check out, filling in their details on the checkout form. When
	# they submit, an order is created containing their information, along with a
	# single line item corresponding to the product they added to their cart.
	test "buying a product" do
		LineItem.delete_all
		Order.delete_all
		ruby_book = products(:ruby)
		get "/"
		assert_response :success
		assert_template "index"
		xml_http_request :post, '/line_items', product_id: ruby_book.id
		assert_response :success
		cart = Cart.find(session[:cart_id])
		assert_equal 1, cart.line_items.size
		assert_equal ruby_book, cart.line_items[0].product
		get "/orders/new"
		assert_response :success
		assert_template "new"
		post_via_redirect "/orders",
				order: { name: "Dave Thomas",
				address: "123 The Street",
				email: "dave@example.com",
				pay_type: "Check" }
		assert_response :success
		assert_template "index"
		cart = Cart.find(session[:cart_id])
		assert_equal 0, cart.line_items.size
		orders = Order.all
		assert_equal 1, orders.size
		order = orders[0]
		assert_equal "Dave Thomas", order.name
		assert_equal "123 The Street", order.address
		assert_equal "dave@example.com", order.email
		assert_equal "Check", order.pay_type
		assert_equal 1, order.line_items.size
		line_item = order.line_items[0]
		assert_equal ruby_book, line_item.product
		mail = ActionMailer::Base.deliveries.last
		assert_equal ["dave@example.com"], mail.to
		assert_equal 'admin@application.com', mail[:from].value
		assert_equal "Order recieving Pragmatic Store", mail.subject
	end
	
	test "should fail on access of sensitive data" do
	    user = users(:one)
	    get "/login" 
	    assert_response :success
	    post_via_redirect "/login", name: user.name, password: 'secret'
	    assert_response :success
	    assert_equal '/admin', path
	
	    get "/users/new" 
	    assert_response :success	    
	    assert_template "new"
		post_via_redirect "create",
				user: { name: "dave",
				password: "secret",
				password_confirmation: "secret"}
	    assert_response :success
		assert_template "index"
	    
	
	    delete "/logout" 
	    assert_response :redirect
	    assert_template "/"      
	
	    get "/users/new" 
	    assert_response :redirect
	    follow_redirect!  
	    assert_equal '/login', path      
    end
	
	test "should logout and not be allowed back in" do
      delete "/logout" 
      assert_redirected_to store_url

      get "/users" 
      assert_redirected_to login_url
   end
end
