# frozen_string_literal: true

# Класс для создания грузовых вагонов
class CargoCar < Car
  def initialize(number, total_place)
    super
    @type = :cargo
  end

  validate :number, :type, String
  validate :total_place, :type, Integer
  validate :total_place, :capacity, (1..500)

  def fill(total_place)
    @used_place += total_place if free_place >= total_place
  end
end
