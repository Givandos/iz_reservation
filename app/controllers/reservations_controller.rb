class ReservationsController < ApplicationController
  def create
    reservation = Reservation.create(reservation_params)

    if reservation.valid?
      render json: reservation, status: :created
    else
      render json: reservation.errors, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.permit(
      :user_id, :table_id, :open_time, :close_time
    )
  end
end
