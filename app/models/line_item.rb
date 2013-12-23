class LineItem < ActiveRecord::Base
  attr_accessible :product, :product_id, :id, :updated_at, :cart_id, :created_at, :price, :quantity
  belongs_to :order
  belongs_to :product
  belongs_to :cart
  def total_price
	product.price * quantity
  end
end
