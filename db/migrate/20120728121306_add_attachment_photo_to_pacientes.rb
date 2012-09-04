class AddAttachmentPhotoToPacientes < ActiveRecord::Migration
  def self.up
    change_table :pacientes do |t|
      t.has_attached_file :photo
    end
  end

  def self.down
    drop_attached_file :pacientes, :photo
  end
end
