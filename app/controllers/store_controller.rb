class StoreController < ApplicationController
  
  skip_before_filter :authorize
  
  def index
  	if session[:counter].nil?
  		session[:counter] = 0
  	end
  	session[:counter] += 1
  	if params[:set_locale]
		redirect_to store_path(locale: params[:set_locale])
	else
		@products = Product.order(:title)
		@cart = current_cart
		@time = Time.now
	end
  end
end
