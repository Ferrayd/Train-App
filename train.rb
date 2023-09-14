# frozen_string_literal: true

# Родительский класс для создания поезда
class Train
  attr_reader :number, :cars, :type, :speed, :route, :station

  include Counter
  include Information
  include Validation

  NUM_FORMAT = /^\w{3}-?\w{2}$/i

  def initialize(number)
    @number = number
    @speed = 0
    @cars = []
    validate!
    register_instance
    self.class.all << self
  end

  def self.all
    # rubocop: disable Style/ClassVars
    @@all ||= []
    # rubocop: enable Style/ClassVars
  end

  def train_composition(&block)
    @cars.each(&block)
  end

  def self.find(number)
    result = all.select { |train| train if train.number == number }
    result.empty? ? nil : result.first
  end

  def stop
    self.speed = 0
  end

  def add_car(car)
    @cars << car if !@cars.member?(car) && car.type == type
  end

  def remove_car(car)
    @cars.delete(car) if car.type == type
  end

  def take_route(route)
    self.route = route
    puts "Поезду №#{number} задан маршрут #{route.name}"
  end

  def go_to(station)
    return if route.nil?

    if @station == station
      puts "Поезд №#{@number} и так на станции #{@station.name}"
    elsif route.stations.include?(station)
      @station&.send_train(self)
      @station = station
      station.get_train(self)
    else
      puts "Станция #{station.name} не входит в маршрут поезда №#{number}"
    end
  end

  def list_all_trains
    print_text('Список поездов:')
    Train.all.each_with_index { |v, i| puts "#{i}. #{v.number}, #{v.type}" }
  end

  def stations_around
    return if route.nil?

    route.stations.index(station)
    stations_next
    station_prev
  end

  def stations_next
    return unless station_index != route.stations.size - 1

    puts "Следующая - #{route.stations[station_index + 1].name}."
  end

  def station_prev
    return unless station_index != 0

    puts "Предыдущая станция - #{route.stations[station_index - 1].name}."
  end

end
