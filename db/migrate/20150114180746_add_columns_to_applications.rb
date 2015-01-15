class AddColumnsToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :position, :string
    add_column :applications, :priority, :string
    add_column :applications, :tier, :string
    add_column :applications, :contact_info, :text
    add_column :applications, :notes, :text
  end
end
