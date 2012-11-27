require "sinatra/base"

module Health
  class Endpoint < Sinatra::Base
    before do
      content_type "application/json"

      if !instance_eval(&Health.endpoint_access_policy)
        halt "Access denied."
      end
    end

    get "/" do
      Health.names.to_json
    end

    get "/:name" do
      pass if !Health.names.include?(params[:name].to_sym)

      value = Health.perform(params[:name])
      status = value[:ok] ? 200 : 500

      [status, value.to_json]
    end
  end
end
