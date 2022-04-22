module Api::V1
  class BaseController < ApplicationController
    rescue_from SlotErrors::InvalidDate, with: :invalid_date
    rescue_from SlotErrors::InvalidDuration, with: :invalid_duration
    rescue_from SlotErrors::SlotUnavailable, with: :slot_unavailable
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

    private

    def invalid_date
      unprocessable 'DATE_INVALID'
    end

    def invalid_duration
      unprocessable 'DURATION_INVALID'
    end

    def slot_unavailable
      unprocessable 'SLOT_UNAVAILABLE'
    end

    def unprocessable_entity
      unprocessable 'INTERNAL_ERROR'
    end

    def unprocessable(code)
      render json: { code: code }, status: :unprocessable_entity
    end
  end
end