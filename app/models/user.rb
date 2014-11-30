class User < ActiveRecord::Base
  #relationships
  has_one :student, dependent: :destroy
  has_one :teacher, dependent: :destroy

  accepts_nested_attributes_for :teacher
  accepts_nested_attributes_for :student

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # @attr_accessible :email, :password, :password_confirmation
  # not required for LDAP :recoverable, :registerable, :validatable
  devise :ldap_authenticatable,:rememberable,:trackable


  validates_uniqueness_of :email, :allow_blank => true
  #validates :first_name, :last_name, length: {in: 3..20}, presence: true
  #validates :email, uniqueness: true

end
