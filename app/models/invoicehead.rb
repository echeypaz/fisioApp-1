# == Schema Information
# Schema version: 20110725171623
#
# Table name: invoiceheads
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  firstsurname  :string(255)
#  secondsurname :string(255)
#  comments      :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  paciente_id   :integer
#

class Invoicehead < ActiveRecord::Base
  attr_accessible :name, :firstsurname, :invoicelines_attributes,:created_at, :paciente_id
  attr_accessor :sessions, :total
  
  has_many  :invoicelines, :dependent => :destroy 
  accepts_nested_attributes_for :invoicelines, :reject_if => lambda { |a| a[:sessions].blank? }, :allow_destroy => true  

  validates :name, :firstsurname, :presence => true
  
  before_create  :set_default_parameters
  
  private
  def set_default_parameters
    code = Countreference.find_by_name('F')
    self.codigo = code.value
    code.value = code.value + 1
    code.save
  end

end
