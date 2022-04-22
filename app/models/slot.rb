class Slot < ApplicationRecord
  scope :filter_by_date, -> (date) { where('DATE(start_time) = :date OR DATE(end_time) = :date', date: date) }
end