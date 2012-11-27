require "sinatra/base"

module Health
  class Endpoint < Sinatra::Base
    before do
      content_type "application/json"

      if !instance_eval(&Healthy.endpoint_access_policy)
        halt "Access denied."
      end
    end

    get "/" do
      Healthy.names.to_json
    end

    get "/:name" do
      pass if !Healthy.names.include?(params[:name].to_sym)

      value = Healthy.perform(params[:name])
      status = value[:ok] ? 200 : 500

      [status, value.to_json]
    end
  end
end
