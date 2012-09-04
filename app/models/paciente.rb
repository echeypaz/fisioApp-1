class Paciente < ActiveRecord::Base
    validates :name, :firstsurname, :presence => true,
                                    :length => { :maximum => 100 }
    validates :idcode,  :uniqueness => { :case_sensitive => false },
                        :format => { :with =>/\d{8}[a-zA-Z]$/i},
                        :allow_blank => true                                    
    validates :birthdate,
              :format => { :with => /(\d{2,4})(\-)(0[0-9]|1[1-2])(\-)(0[0-9]|1[0-9]|2[0-9]|3[0-1])/},
              :allow_blank => true
    validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i },
              :allow_blank => true
    validates :profession, :email, :length => {:maximum => 150}
    
    has_many :clinicalhistories, :inverse_of => :paciente, :dependent => :destroy, :order => 'assessmentdate DESC'
    has_many :events, :dependent => :destroy
    belongs_to  :idtype
    
    has_many :assets, :dependent => :destroy
    accepts_nested_attributes_for :assets, :allow_destroy => true

    has_attached_file :photo
    accepts_nested_attributes_for :clinicalhistories, :allow_destroy => true  

    before_create  :set_default_parameters

    def self.age(birthdate)
      if !birthdate.blank?
        ((DateTime.now - birthdate)/365).to_i
      end
    end 
    #Función para definir qué queremos mostrar en el autcompletar.
    def funky_method
      "#{self.name} #{self.firstsurname} #{self.secondsurname}, #{self.idcode}"
    end
  
    def last_clinicalhistory
      self.clinicalhistories.first
    end    
      
    private
      def set_default_parameters
        code = Countreference.find_by_name('P')
        self.codigo = code.value
        code.value = code.value + 1
        self.fullname = "#{self.name} #{self.firstsurname} #{self.secondsurname}, #{self.idcode}"
        code.save
      end

end

