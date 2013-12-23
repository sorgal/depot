class User < ActiveRecord::Base
  attr_accessible :name, :password_confirmation, :password
  validates :name, presence: true, uniqueness: true
  validates_confirmation_of :password
  has_secure_password
  
  after_destroy :ensure_an_admin_remains
  private
	def ensure_an_admin_remains
		if User.count.zero?
		raise "You can't delete last user"
	end
  end
  
end
