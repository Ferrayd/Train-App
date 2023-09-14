# frozen_string_literal: true

ACTIONS = [
  {
    id: 0,
    action: :close
  },
  {
    id: 1,
    action: :create_station
  },
  {
    id: 2,
    action: :create_train
  },
  {
    id: 3,
    action: :create_car
  },
  {
    id: 4,
    action: :add_wagon_to_train
  },
  {
    id: 5,
    action: :remove_wagon_from_train
  },
  {
    id: 6,
    action: :move_train_to_station
  },
  {
    id: 7,
    action: :list_stations
  },
  {
    id: 8,
    action: :list_trains_on_station
  },
  {
    id: 9,
    action: :list_all_trains
  },
  {
    id: 10,
    action: :train_car_list
  }
].freeze

MENU = ['Выход', 'Создать станцию', 'Создать поезд', 'Создать вагон', 'Прицепить вагон к поезду',
        'Отцепить вагон от поезда', 'Поместить поезд на станцию', 'Просмотреть список станций',
        'Просмотреть список поездов находящихся на станции', 'Список всех поездов', 'Список вагонов поезда'].freeze
