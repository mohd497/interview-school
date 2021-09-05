class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.time :start_time
      t.time :end_time
      t.references :teacher, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.string :classroom_name

      t.timestamps
    end
  end
end
