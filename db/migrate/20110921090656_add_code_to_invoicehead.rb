class AddCodeToInvoicehead < ActiveRecord::Migration
  def self.up
    add_column :invoiceheads, :code, :integer
  end

  def self.down
    remove_column :invoiceheads, :code
  end
end
