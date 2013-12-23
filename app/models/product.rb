class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title
  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  private
  # убеждаемся в отсутствии товарных позиций, ссылающихся на данный товар
  def ensure_not_referenced_by_any_line_item
	if line_items.empty?
    	return true
	else
		errors.add(:base, 'line items detected')
		return false
	end
  end
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, length: {minimum: 10, message: "product title must greater or equal to 10 chars"}, uniqueness: true
  validates :image_url, allow_blank: true, format: {
	with: %r{\.(gif|jpg|png)$}i,
	message: 'must be a URL for GIF, JPG or PNG image.'
  }
end
