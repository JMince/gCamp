class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  has_secure_password
  validates :password, :presence => true
  validates :password_confirmation, :presence => true, :confirmation => true
end
