module Health
  class Checker
    def checks
      @checks ||= {}
    end

    def configure(&block)
      instance_eval(&block)
    end

    def check(name_or_object, &block)
      if name_or_object.respond_to?(:call)
        checks[name_or_object.name] = name_or_object
      else
        checks[name_or_object] = block
      end
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
