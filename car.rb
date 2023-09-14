# frozen_string_literal: true

# Родительский класс для создания вагонов
class Car
  attr_reader :number, :total_place, :used_place, :type

  include Information
  include Validation

  def initialize(number, total_place)
    @number = number
    @total_place = total_place
    @used_place = 0
    validate!
    self.class.all << self
  end

  def self.all
    # rubocop: disable Style/ClassVars
    @@all ||= []
    # rubocop: enable Style/ClassVars
  end

  def free_place
    total_place - used_place
  end
end
