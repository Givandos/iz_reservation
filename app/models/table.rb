# frozen_string_literal: true
class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :reservations

  validates :restaurant,
            presence: true

  def available?(start_date, end_date)
    open_hours = restaurant.open_hours_in_visit_date(start_date)
    if start_date < open_hours[:opening]
      open_hours = restaurant.open_hours_in_visit_date(start_date - 1.day)
    end

    unless open_hours[:opening] <= start_date &&
           open_hours[:closing] >= end_date
      return false
    end

    # TODO - need refactor
    !reservations.exists?("(open_time >= #{start_date} AND
                            open_time <= #{end_date}) OR
                           (close_time >= #{start_date} AND
                            close_time <= #{end_date})")
  end
end
