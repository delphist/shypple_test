# frozen_string_literal: true

module Sailings
  module Adapter
    class JsonFile
      DEFAULT_PATH = 'db/response.json'
      PERMITTED_ATTRIBUTES = %w[origin_port destination_port sailing_code].freeze

      def initialize(path: nil)
        @path = path
      end

      def all
        data['sailings'].map do |row|
          @row = row
          Sailing.new(attributes)
        end
      end

      private

      attr_reader :row

      def attributes
        {
          **row.slice(*PERMITTED_ATTRIBUTES).symbolize_keys,
          departure_date: Date.parse(row['departure_date']),
          arrival_date: Date.parse(row['arrival_date']),
          rate_currency: rate['rate_currency'],
          rate: BigDecimal(rate['rate'].to_s),
          exchanged_rate: BigDecimal(rate['rate'].to_s) * exchange_rate
        }
      end

      def rate
        data['rates'].find { |e| e['sailing_code'] == row['sailing_code'] }
      end

      def exchange_rate
        return 1 if rate['rate_currency'] == 'EUR'

        BigDecimal(data['exchange_rates'].dig(row['departure_date'], rate['rate_currency'].downcase).to_s)
      end

      def data
        return @data if @data.present?

        file = File.open(Rails.root.join(path))
        @data = JSON.parse(file.read)
      end

      def path
        @path || DEFAULT_PATH
      end
    end
  end
end
