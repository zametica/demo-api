module Api::V1
  module Slots
    class Availability
      #00:00 - 06:00
      #09:00 - 10:00
      #10:15 - 10:45
      #11:30 - 13:00
      #13:00 - 13:10
      #13:55 - 14:30
      #20:00 - 22:30
  
      def initialize(params)
        date_parsed = DateTime.parse(params[:date]).beginning_of_day
        @date = date_parsed.to_date === Time.current.to_date ?
          Time.current : date_parsed
        @duration = params[:duration].to_i
        @end_date = (@date + 1.day).beginning_of_day
        @booked_on_day = get_booked params[:date]
      end
  
      def check  
        available_slots = []

        raise SlotErrors::InvalidDuration if duration <= 0;
  
        (date.to_i..end_date.to_i)
          .step(15.minutes)
          .each do |t|
            start_time = Time.at(t).utc
            end_time = start_time + duration.minutes
  
            break if end_time >= end_date
  
            unless (date_overlaps? start_time, end_time)
              available_slots << { start: start_time, end: end_time }
            end
        end
  
        available_slots.sort { |p, n| p[:start] <=> n[:start] }
      end
  
      private
  
      attr_reader :date, :duration, :end_date, :booked_on_day
  
      def get_booked(date)
        Slot.filter_by_date Date.parse(date)
      end
  
      def date_overlaps?(start_time, end_time)
        booked_on_day.any? do |slot|
          (slot.start_time.to_i..slot.end_time.to_i)
            .overlaps? (start_time.to_i..end_time.to_i)
        end
      end
    end
  end
end
