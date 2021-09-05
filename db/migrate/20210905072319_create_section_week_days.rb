class CreateSectionWeekDays < ActiveRecord::Migration[6.0]
  def change
    create_table :section_week_days do |t|
      t.references :section, null: false, foreign_key: true
      t.references :week_day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
