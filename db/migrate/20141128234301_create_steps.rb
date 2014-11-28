class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :kind
      t.integer :application_id
      t.text :note

      t.timestamps
    end
  end
end
