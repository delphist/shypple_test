# frozen_string_literal: true

class Sailing
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :origin_port, :destination_port, :departure_date, :arrival_date, :sailing_code,
                :rate, :rate_currency, :exchanged_rate

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
end
