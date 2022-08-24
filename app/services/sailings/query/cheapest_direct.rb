# frozen_string_literal: true

module Sailings
  module Query
    class CheapestDirect < Base
      def call
        cheapest_direct_sailings.min { |e| e.exchanged_rate }
      end

      def cheapest_direct_sailings
        sailings.select do |sailing|
          sailing.origin_port == origin_port && sailing.destination_port == destination_port
        end
      end
    end
  end
end
