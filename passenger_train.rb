# frozen_string_literal: true

# Класс для создания пасажирских поездов
class PassengerTrain < Train
  def initialize(number)
    super
    @type = :passenger
  end

  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, NUM_FORMAT
end
