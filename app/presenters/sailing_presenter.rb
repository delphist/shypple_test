# frozen_string_literal: true

class SailingPresenter
  def initialize(sailing)
    @sailing = sailing
  end

  def as_json
    {
      "origin_port": sailing.origin_port,
      "destination_port": sailing.destination_port,
      "departure_date": sailing.departure_date,
      "arrival_date": sailing.arrival_date,
      "sailing_code": sailing.sailing_code,
      "rate": sailing.rate,
      "rate_currency": sailing.rate_currency
    }
  end

  private

  attr_reader :sailing
end
