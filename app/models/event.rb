class Event < ActiveRecord::Base
  attr_accessible   :starts_at, :ends_at, :all_day, :description, :center_id, :specialist_id, :paciente_id,:attended, :invoiceline_id, :clinicalhistory, 
                    :name, :firstsurname, :secondsurname
 
  belongs_to  :center
  belongs_to  :specialist
  belongs_to  :paciente
  has_one     :invoiceline
  belongs_to  :clinicalhistory
  validates :specialist_id, :center_id, :name, :firstsurname, :secondsurname, :presence => true

  validate :dates
  before_save  :set_default_parameters

  scope :before, lambda {|end_time| {:conditions => ["ends_at < ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["starts_at > ?", Event.format_date(start_time)] }}
   
  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/

  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :description => self.description,
      :start => starts_at.rfc822,
      :end => ends_at.rfc822,
      :allDay => self.all_day,
      :recurring => false,
      :url => Rails.application.routes.url_helpers.event_path(id),
      :center_id => self.center_id,
      :attended => self.attended,
      :paciente_id => self.paciente_id,
      :specialist_id => self.specialist_id,
    }
    
  end
  
  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
  
  def set_default_parameters
      self.title = "#{self.name} #{self.firstsurname} #{self.secondsurname}"
      self.description = "#{self.specialist.name}, #{self.center.name}"
      self.ends_at = self.starts_at + 1
  end

  def dates
    if starts_at.blank? || ends_at.blank?
      errors.add(:starts_at, :blank)
    end
  end

end
