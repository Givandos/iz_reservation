class Reservation < ApplicationRecord
  MIN_RESERVATION_MINUTES = 30
  INTERVAL_RESERVATION_MINUTES = 30

  belongs_to :user
  belongs_to :table

  validates :user, :table, :open_time, :close_time,
            presence: true

  validate :close_time_after_open_time,
           :min_reservation_duration,
           :reservation_interval,
           :table_availability

  private

  def close_time_after_open_time
    return if close_time > open_time

    errors.add :close_time,
               "should be more than open_time"
  end

  def min_reservation_duration
    min_close_time = open_time +
                     MIN_RESERVATION_MINUTES.minutes

    return if min_close_time <= close_time

    errors.add :close_time,
               "should be equal or more than #{min_close_time}"
  end

  def reservation_interval
    time_diff_minutes = (close_time - open_time) / 60
    return if (time_diff_minutes % INTERVAL_RESERVATION_MINUTES).zero?

    errors.add :close_time,
               "should be with 30-minutes interval"
  end

  def table_availability
    return if table.available?(open_time, close_time)

    errors.add :table_id, "table is unavailable on this dates"
  end
end
