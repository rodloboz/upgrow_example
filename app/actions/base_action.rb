# frozen_string_literal: true

class BaseAction
  class << self
    attr_writer :result_class

    def result_class
      @result_class ||= ActionResult.new
    end

    def result(*args)
      @result_class = ActionResult.new(*args)
    end
  end

  def result
    self.class.result_class
  end
end
