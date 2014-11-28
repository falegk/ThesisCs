class Project < ActiveRecord::Base
  belongs_to :teacher
  has_many   :management_dissertations

  accepts_nested_attributes_for :management_dissertations
end
