class User < ActiveRecord::Base
  validates :email, uniqueness: true
  validates :first_name, :last_name, :email, presence: true
end
