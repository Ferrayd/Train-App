# frozen_string_literal: true

# Родительский класс для создания вагонов
class Car
  attr_reader :number, :type, :total_place, :used_place

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

  def print_cars
    print_text('Список вагонов:')
    Car.all.each_with_index { |v, i| puts "#{i}. #{v.number}, #{v.type}" }
  end

  protected

end
