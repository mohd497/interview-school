class WeekDay < ApplicationRecord
	has_many :section_week_days
	has_many :section_students
	has_many :sections, through: :section_week_days
end
