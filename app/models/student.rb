class Student < ActiveRecord::Base
  belongs_to :user
  has_many :management_dissertations
  #has_many :projects, through: :management_dissertations

  accepts_nested_attributes_for :management_dissertations
end
