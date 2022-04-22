module Api::V1
  module Slots
    class Create
      def initialize(params)
        @start_time = params[:start_time]
        @end_time = params[:end_time]
      end

      def call
        raise SlotErrors::SlotUnavailable unless valid?
        Slot.create!({ start_time: start_time, end_time: end_time })
      end

      private

      attr_reader :start_time, :end_time

      def valid?
        date = Date.parse start_time
        slots = Slot.filter_by_date date
        slots.none? do |slot|
          (slot.start_time.to_i..slot.end_time.to_i)
            .overlaps? (start_time.to_i..end_time.to_i)
        end
      end
    end
  end
end