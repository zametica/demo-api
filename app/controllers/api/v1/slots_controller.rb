module Api::V1
  class SlotsController < BaseController
    def index
      render json: get_available, status: :ok
    end

    def create
      render json: create_slot, status: :created
    end

    private

    def filter_params
      params.permit(:date, :duration)
    end

    def create_params
      params.permit(:start_time, :end_time)
    end

    def get_available
      Slots::Availability.new(filter_params).check
    end

    def create_slot
      Slots::Create.new(create_params).call
    end
  end
end
