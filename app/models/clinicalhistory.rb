class Clinicalhistory < ActiveRecord::Base
      attr_accessor :duplicado             
      belongs_to  :paciente, :inverse_of => :clinicalhistories
      belongs_to  :rate      
      belongs_to  :provenance
      belongs_to  :center
      belongs_to  :specialist
      belongs_to  :specialisttype

      paginates_per 1
      has_many  :events
      before_create :set_default_parameters
      private
        def set_default_parameters
          self.assessmentdate = Date.today.to_s
          code = Countreference.find_by_name('C')
          self.code = code.value
          code.value = code.value + 1
          code.save
        end
        
      
end
