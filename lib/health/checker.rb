module Health
  class Checker
    def checks
      @checks ||= {}
    end

    def check(name_or_object, &block)
      if name_or_object.respond_to?(:call)
        checks[name_or_object.name.to_sym] = name_or_object
      else
        checks[name_or_object.to_sym] = block
      end
    end

    def has_check?(name)
      checks.has_key?(name.to_sym)
    end

    def names
      checks.keys
    end

    def perform(name)
      checks[name.to_sym].call.tap do |result|
        assert_necessary_keys(result)
      end
    end

    private
      def assert_necessary_keys(result)
        (result.has_key?(:ok) && result.has_key?(:output)) ||
          raise("Check results MUST have :ok and :output keys.")
      end
  end
end
