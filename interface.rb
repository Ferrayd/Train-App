# frozen_string_literal: true

# Класс интерфейса
class TrainApp
  def initialize
    @routes = []
    @stations = []
    @close = false
  end

  def action
    render until @close
  end

  def render
    show_actions
    user_action = gets.chomp.to_i
    return puts 'Необходимо выбрать один из предложенных вариантов' if user_action > ACTIONS.length - 1

    action_item = ACTIONS.fetch(user_action)
    send(*action_item[:action])
  end

  def close
    @close = true
  end

  private

  def print_text(text)
    puts text
  end

  def show_actions
    MENU.each_with_index { |item, index| puts "#{index}. #{item}" }
  end

  def ask(question)
    puts question
    gets.chomp
  end

  def create_station
    name = ask('Введите название станции')
    @stations << Station.new(name)
    print_text("Построена станция #{name}")
  end

  def create_route
    list_stations
    first_station_name = ask('Введите начальную станцию:')
    first_station = @stations.find { |station| station.name = first_station_name }
    last_station_name = ask('Введите конечную станцию:')
    last_station = @stations.find { |station| station.name = last_station_name }
    @routes << Route.new(first_station, last_station)
  end

  def add_station; end

  def create_train
    number = ask('C каким номером?')
    choice = ask('1 - пассажирский, 2 - грузовой').to_i
    return puts 'Ошибка, выберите 1 или 2' unless [1, 2].include?(choice)

    choice == 1 ? PassengerTrain.new(number) : CargoTrain.new(number)
    print_text("Создан поезд #{Train.all.last.type} №#{number}")
  end

  def create_car
    number = ask('Введите номер вагона:')
    choice = ask('Выберите тип вагона: 1 - пассажирский, 2 - грузовой').to_i
    capacity = ask('Укажите количество мест/Объем').to_i
    return puts 'Ошибка, выберите 1 или 2' unless [1, 2].include?(choice)

    choice == 1 ? PassengerCar.new(number, capacity) : CargoCar.new(number, capacity)
    print_text("Создан новый вагон <#{Car.all.last.number}>")
  end

  def add_wagon_to_train
    list_all_trains
    train = Train.all[ask('Добавляем вагон поезду. Выберите поезд:').to_i]
    print_cars
    train.add_car(Car.all[ask('Выберите вагон:').to_i])
  end

  def remove_wagon_from_train
    train = Train.all[ask('Отцепляем вагон от поезда. Выберите поезд:').to_i]
    train.remove_car(train.cars[ask('Выберите вагон:').to_i])
  end

  def choose_station
    list_stations
    name = ask('На какую станцию? (название)')
    @stations.detect { |station| station.name == name }
  end

  def move_train_to_station
    return unless !Train.all && @stations.empty?

    train = Train.all[ask('Какой поезд?').to_i]
    station = choose_station
    station.nil? ? print_text('Такой станции нет') : station.get_train(train)
  end

  def trains_on_station
    station = choose_station
    print_text("Список поездов на стации <#{station.name}>")
    station.all_trains do |train|
      print_text("Поезд #{train.number} (тип: #{train.type}) #{"вагонов: #{train.cars.count}"}")
    end
  end

  def train_car_list
    list_all_trains
    train = Train.all[ask('Выберите поезд: ').to_i]
    print_text("Список вагонов поезда <#{train.number}>")
    train.train_composition do |car|
      print_text("Вагон № #{car.number} (тип: #{car.type})
Загрузка: #{car.used_place} из #{car.total_place}, свободно: #{car.free_place}")
    end
  end

  def list_stations
    print_text('Список станций:')
    @stations.each { |station| puts station.name }
  end
end
