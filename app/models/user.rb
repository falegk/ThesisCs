class User < ActiveRecord::Base

  has_one :student, dependent: :destroy
  has_one :teacher, dependent: :destroy

  accepts_nested_attributes_for :teacher
  accepts_nested_attributes_for :student


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauth==able
  # @attr_accessible :email, :password, :password_confirmation
  # not required for LDAP :recoverable, :registerable, :validatable
  devise :ldap_authenticatable,:rememberable,:trackable


  validates_uniqueness_of :email, :allow_blank => true
  #validates_format_of :email, with: VALID_STUDENT_CS_REGEX
  #validates :first_name, :last_name, length: {in: 3..20}, presence: true
  #validates :email, uniqueness: true



  # -------------- Μέθοδοι χειρισμού του LDAP -----------------

  def get_ldap_userType
    value = Devise::LDAP::Adapter.get_ldap_param(self.email,"businessCategory").first.force_encoding("UTF-8")
    value
  end

end
