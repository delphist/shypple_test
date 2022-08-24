# frozen_string_literal: true

require 'priority_queue'

module Sailings
  module Query
    # https://dzone.com/articles/ruby-graph-dijkstra
    class Graph
      def initialize
        @g = {}
        @nodes = []
        @INFINITY = 1 << 64
      end

      def add_edge(sailing)
        origin = sailing.origin_port
        destination = sailing.destination_port

        if !@g.key?(origin)
          @g[origin] = { destination => [sailing] }
        else
          @g[origin][destination] ||= []
          @g[origin][destination] << sailing
        end

        @nodes << origin unless @nodes.include?(origin)

        @nodes << destination unless @nodes.include?(destination)
      end

      def dijkstra(s)
        @d = {}
        @prev = {}

        @nodes.each do |i|
          @d[i] = { w: @INFINITY, s: nil }
          @prev[i] = -1
        end

        @d[s][:w] = 0
        q = @nodes.compact
        while q.size.positive?
          u = nil
          q.each do |min|
            u = min if !u || (@d[min][:w] && (@d[min][:w] < @d[u][:w]))
          end
          break if @d[u] == @INFINITY

          q -= [u]

          @g[u]&.keys&.each do |v|
            @g[u][v].each do |k|
              alt = @d[u][:w] + k.exchanged_rate

              if alt < @d[v][:w]
                @d[v] = { w: alt, s: k }
                @prev[v] = k
              end
            end
          end
        end
      end

      def get_path(destination)
        result = []

        if @prev[destination] != -1
          result += get_path(@prev[destination].origin_port)
          result << @prev[destination]
        end

        result
      end

      def shortest_path(origin, destination)
        @source = origin
        dijkstra(origin)

        if @d[destination] != @INFINITY
          get_path(destination)
        else
          []
        end
      end
    end

    class Indirect < Base
      def call
        gr = Graph.new
        sailings.each do |sailing|
          gr.add_edge(sailing)
        end

        gr.shortest_path(origin_port, destination_port)
      end
    end
  end
end
