xml.div(class: "productlist") do
	xml.timestamp(Time.now)
	@product.orders.each do |order|
		xml.product do
			xml.title "Order #{order.id}"
			xml.p "Shipped to #{order.address}"
			xml.table do
					xml.tr do
						xml.th 'Product'
						xml.th 'Quantity'
						xml.th 'Total Price'
					end
					order.line_items.each do |item|
						xml.tr do
							xml.td item.product.title
							xml.td item.quantity
							xml.td number_to_currency item.total_price
						end
					end
					xml.tr do
						xml.th 'total', colspan: 2
						xml.th number_to_currency \
						order.line_items.map(&:total_price).sum
					end
				end
				xml.p "Paid by #{order.pay_type}"
		end
	end
end