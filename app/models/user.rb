class User < ActiveRecord::Base
  has_one :student, dependent: :destroy
  has_one :teacher, dependent: :destroy

  accepts_nested_attributes_for :teacher
  accepts_nested_attributes_for :student

  validates :first_name, :last_name, length: {in: 3..20}, presence: true
  validates :email, uniqueness: true

end
