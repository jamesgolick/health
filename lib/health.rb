module Health
  autoload :Checker,  "health/checker"
  autoload :Checks,   "health/checks"
  autoload :Endpoint, "health/endpoint"

  class << self
    def checker
      @checker ||= Checker.new
    end

    def configure(&block)
      instance_eval(&block)
    end

    def check(name_or_object, &block)
      checker.check(name_or_object, &block)
    end

    def has_check?(name)
      checker.has_check?(name)
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
