module SlotErrors
  class Error < RuntimeError; end
  class InvalidDate < Error; end
  class InvalidDuration < Error; end
  class SlotUnavailable < Error; end
end