# frozen_string_literal: true

# Модуль для подсчета инстансов
module Counter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # Модуль для подсчета методов класса
  module ClassMethods
    def instances
      @instances
    end

    def increase
      @instances = 0 if @instances.nil?
      @instances += 1
    end
  end

  # Модуль для увеличения инстанс методов
  module InstanceMethods
    def register_instance
      self.class.increase
    end
  end
end
