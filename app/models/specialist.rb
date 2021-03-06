class Specialist < ActiveRecord::Base
  attr_accessible  :name,  :specialisttype_id, :email, :phone1, :phone2
  has_many  :events
  has_many  :clinicalhistories
  belongs_to  :specialisttype
end
