class Section < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject
  has_many :section_week_days
  has_many :section_students
  has_many :week_days, through: :section_week_days
  has_many :students, through: :section_students

  after_validation :check_if_duplicate

  def check_if_duplicate
    student = get_student(self.student_ids)
    student.sections.each do |sec|
      check_conflict(sec, self)
    end
  end

  def check_conflict(prev_record, now)
    matching_days = prev_record.week_days.pluck(:name) &  now.week_days.pluck(:name)
    if matching_days
      conflict_time = check_time_conflict?(prev_record, now)
    end

    if conflict_time
      errors.add(:alert, "Schedule is overlapping")
    end  
  end

  def check_time_conflict?(prev_record, now)
    (now.start_time - prev_record.end_time) * (prev_record.start_time - now.end_time) > 0    
  end  

  def get_student(student_ids)
    Student.find(self.student_ids).first
  end 
end
