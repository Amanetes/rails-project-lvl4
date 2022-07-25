# frozen_string_literal: true
# TODO перенести логику в сервис?
class Repository
  class CheckService
    class << self
      def run_check(check)
        check.check!
        repository = ApplicationContainer[:repository_loader] # Качаем репозиторий
        # Проверяем линтером
        # Парсим результат
        check.finish!
      rescue StandardError
        check.reject!
      end
      end
  end
end
