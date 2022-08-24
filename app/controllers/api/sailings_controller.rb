# frozen_string_literal: true

module Api
  class SailingsController < ApplicationController
    def cheapest_direct
      render json: present(Sailings::Query::CheapestDirect.new(service_parameters).call)
    end

    def cheapest_indirect
      render json: present_collection(Sailings::Query::Indirect.new(service_parameters).call)
    end

    private

    def service_parameters
      {
        adapter: adapter,
        origin_port: params[:origin_port],
        destination_port: params[:destination_port]
      }
    end

    def adapter
      Sailings::Adapter::JsonFile.new
    end

    def present(sailing)
      SailingPresenter.new(sailing).as_json
    end

    def present_collection(sailings)
      sailings.map do |sailing|
        present(sailing)
      end
    end
  end
end
