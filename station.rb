# frozen_string_literal: true

# Класс для создания станций
class Station
  attr_reader :name

  include Counter
  include Validation

  def initialize(name)
    @name = name
    @trains = []
    validate!
    register_instance
    self.class.all << self
  end

  def self.all
    # rubocop: disable Style/ClassVars
    @@all ||= []
    # rubocop: enable Style/ClassVars
  end

  def all_trains(&block)
    @trains.each(&block)
  end

  def get_train(train)
    @trains << train
    puts "На станцию #{name} прибыл поезд №#{train.number}"
  end

  def send_train(train)
    @trains.delete(train)
    train.station = nil
    puts "Со станции #{name} отправился поезд №#{train.number}"
  end

  protected

  def validate!
    raise 'Ошибка валидации: название должно быть текстовым' if @name.class != String
    raise 'Ошибка валидации: Не указано название станции!' if @name.empty?
  end
end
