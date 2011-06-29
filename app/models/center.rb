# == Schema Information
# Schema version: 20110623111357
#
# Table name: centers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Center < ActiveRecord::Base
  has_many :events
end
