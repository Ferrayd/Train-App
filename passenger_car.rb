# frozen_string_literal: true

# Класс для создания пасажирских вагонов
class PassengerCar < Car
  def initialize(number, seats)
    @type = :passenger
    super
  end

  validate :number, :presence
  validate :number, :type, String
  validate :seats, :type, Integer
  validate :seats, :seats, (1..100)

  def take_seat
    @used_place += 1 if free_place.positive?
  end
end
