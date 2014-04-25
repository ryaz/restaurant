class Reservation < ActiveRecord::Base

  scope :by_table_id, ->(table_id) { where(table_id: table_id) }
  scope :overlapping, ->(start_time, end_time) { 
    where("start_time BETWEEN :start_time AND :end_time OR
             end_time BETWEEN :start_time AND :end_time OR
             (start_time < :start_time AND end_time > :end_time)",
             start_time: start_time, end_time: end_time)
  }
  scope :not_self_id, ->(id) { where.not(id: id) if id }

  validates :table_id, :start_time, :end_time, presence: true
  validates :table_id, numericality: {greater_than_or_equal_to: 1}

  validate :validate_times, :overbooking

  def overbooking
    if self.class.by_table_id(table_id).overlapping(start_time, end_time).not_self_id(id).any?
      errors.add(:base, "is already booked")
    end
  end

  def validate_times
    if end_time && start_time && end_time <= start_time
      errors.add(:base, "end_time must be after than start_time")
    end
  end
end


