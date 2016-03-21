class HiveMindTv::ApiController < ApplicationController
  # This turns off CSRF verification for the API
  # TODO Provide other methods of authentication
  skip_before_action :verify_authenticity_token

  def set_application
    response = {}
    status = :ok

    if ! params[:device][:id]
      response = { error: 'Missing device id' }
      status = :unprocessable_entity
    elsif device = Device.find_by(id: params[:device][:id])
      if device.plugin_type == 'HiveMindTv::Plugin'
        device.plugin.application = params[:device][:application]
        device.plugin.save
      else
        response = { error: 'Device is not a TV' }
        status = :unprocessable_entity
      end
    else
      response = { error: 'Unknown device' }
      status = :not_found
    end

    render json: response, status: status
  end
end
