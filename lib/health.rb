module Health
  autoload :Checker,  "health/checker"
  autoload :Checks,   "health/checks"
  autoload :Endpoint, "health/endpoint"

  class << self
    def checker
      @checker ||= Checker.new
    end

    def configure(&block)
      checker.configure(&block)
    end

    def perform(name)
      checker.perform(name)
    end

    def names
      checker.names
    end

    def endpoint_access_policy(&block)
      if block_given?
        @endpoint_access_policy = block
      else
        @endpoint_access_policy ||= proc { true }
      end
    end
  end
end
