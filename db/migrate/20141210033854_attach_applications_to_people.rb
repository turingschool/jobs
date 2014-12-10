class AttachApplicationsToPeople < ActiveRecord::Migration
  def change
    add_column :applications, :person_id, :integer
  end
end
