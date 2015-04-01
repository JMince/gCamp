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

  def token_privacy
    self.pivotal_token[0..3] + ('*'*(self.pivotal_token.length - 4))
  end

  def owner_admin?(project)
    self.memberships.find_by(project_id: project.id, user_id: self.id).role == 1 && self.memberships.find_by(project_id: project.id, user_id: self.id) != nil || self.admin
  end
end
