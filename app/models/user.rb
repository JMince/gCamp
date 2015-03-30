class User < ActiveRecord::Base

    validates :first_name, :last_name, :email, presence: true
    validates :email, uniqueness: true

    has_secure_password
    validates :password_confirmation, :presence => true, :confirmation => true

    has_many :memberships, dependent: :destroy
    has_many :projects, through: :memberships

    has_many :comments, dependent: :nullify
    has_many :tasks, through: :comments

    def full_name
      "#{first_name} #{last_name}"
    end

end
