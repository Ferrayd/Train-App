# frozen_string_literal: true

# Модуль для валидации
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate!
      self.class.validations.each do |v|
        eval("validate_#{v[:validation_type]}(v)")
      end
    end

    def validate_type(params)
      value = eval("@#{params[:var_name]}")
      return if value.is_a?(params[:option])

      raise ArgumentError,
            "Несоответствие типов: реквизит #{params[:var_name]} должен иметь тип #{params[:option]}"
    end

    def validate_presence(params)
      value = eval("@#{params[:var_name]}")
      raise ArgumentError, "Не задано значение реквизита #{params[:var_name]}!" if value.nil? || value.to_s.empty?
    end

    def validate_format(params)
      value = eval("@#{params[:var_name]}")
      raise ArgumentError, "Некорректный формат реквизита #{params[:var_name]}" if value !~ params[:option]
    end

    def validate_capacity(params)
      value = eval("@#{params[:var_name]}")
      raise 'Вместимость указана некорректно!' unless (1..100).include?(value)
    end
  end

  module ClassMethods
    def validate(var_name, validation_type, option = nil)
      validations << { var_name:, validation_type:, option: }
    end

    def validations
      @validations ||= []
    end
  end
end
