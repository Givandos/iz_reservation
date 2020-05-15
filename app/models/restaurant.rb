class Restaurant < ApplicationRecord
  has_many :tables
  has_many :reservations, through: :tables

  validates :open_time, :close_time,
            presence: true

  def open_hours_in_visit_date(desired_date)
    {
      opening: opening_datetime(desired_date),
      closing: closing_datetime(desired_date)
    }
  end

  private

  def opening_datetime(checked_date)
    checked_date.to_date +
      open_time.hour.hours +
      open_time.min.minutes
  end

  def closing_datetime(checked_date)
    is_next_date = open_time > close_time

    checked_date = checked_date.to_date
    checked_date += 1.day if is_next_date

    checked_date +
      close_time.hour.hours +
      close_time.min.minutes
  end
end
