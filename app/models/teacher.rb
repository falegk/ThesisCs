class Teacher < ActiveRecord::Base
  belongs_to :user
  has_many :projects

  accepts_nested_attributes_for :projects

  #validates :department, presence: true
  #validates :email_communication, presence: true
  validates_numericality_of :dissertation_number, only_integer: true,
                            greater_than_or_equal_to: 10,
                            less_than_or_equal_to: 30,
                            message: 'Ο αριθμός των πτυχιακών πρέπει να είναι μεταξύ 10 και 30'

end
