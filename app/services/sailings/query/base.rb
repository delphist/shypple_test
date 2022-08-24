# frozen_string_literal: true

module Sailings
  module Query
    class Base
      def initialize(adapter:, origin_port:, destination_port:)
        @adapter = adapter
        @origin_port = origin_port
        @destination_port = destination_port
      end

      def call
        raise 'Not Implemented'
      end

      private

      def sailings
        adapter.all
      end

      attr_reader :adapter, :origin_port, :destination_port
    end
  end
end
