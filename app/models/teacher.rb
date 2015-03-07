class Teacher < ActiveRecord::Base
  belongs_to :user
  has_many :projects

  accepts_nested_attributes_for :projects

  #validates :department, presence: true
  #validates :email_communication, presence: true
end
