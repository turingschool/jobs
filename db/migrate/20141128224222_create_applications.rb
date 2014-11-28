class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :company
      t.string :location
      t.string :url
      t.date :applied_on
      t.string :status

      t.timestamps
    end
  end
end
