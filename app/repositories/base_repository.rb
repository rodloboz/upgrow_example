# frozen_string_literal: true

class BaseRepository
  class << self
    def transaction
      ActiveRecord::Base.transaction { yield(new) }
    end

    def model_name=(value)
      @model_name = value&.to_s
    end

    def model_name
      @model_name ||= to_s.demodulize.underscore.split('_').first.singularize.capitalize
    end

    def record_name=(value)
      @record_name = value&.to_s
    end

    def record_name
      @record_name ||= "#{model_name}Record".classify
    end
  end

  def all
    record_class.all.map { |record| to_model(record.attributes) }
  end

  def create(**args)
    record = record_class.create!(args)
    to_model(record.attributes)
  end

  def find(id)
    record = record_class.find(id)
    to_model(record.attributes)
  end

  def update(id, **args)
    record = record_class.find(id)
    record.update!(args)
    to_model(record.attributes)
  end

  def delete(id)
    record = record_class.find(id)
    record.destroy!
  end

  private

  def record_name
    self.class.record_name
  end

  def model_name
    self.class.model_name
  end

  def record_class
    record_name.constantize
  end

  def to_model(attributes)
    model_name.constantize.new(**attributes.symbolize_keys)
  end
end
