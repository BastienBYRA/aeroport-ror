class Flight < ActiveRecord::Base
  paginates_per 10

  def getMaxAvailableSeats(seatType)
    if seatType == "Economique" || seatType == nil
      economy_class_seats > 99 ? 99 : economy_class_seats
    elsif seatType == "Affaire"
      business_class_seats > 99 ? 99 : economy_class_seats
    end
  end
end
