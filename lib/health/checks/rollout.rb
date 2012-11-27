module Health
  module Checks
    class Rollout
      def initialize(rollout_name, rollout = $rollout)
        @rollout_name = rollout_name
        @rollout = rollout
      end

      def name
        "#{@rollout_name}_rollout"
      end

      def call
        {:ok     => @rollout.active?(@rollout_name),
         :output => @rollout.get(@rollout_name).to_hash}
      end
    end
  end
end
