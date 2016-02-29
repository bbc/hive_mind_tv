class HiveMindTv::ApiController < ApplicationController
  def set_application
    response = {}
    status = :ok

    if device = Device.find_by(params[:device][:id])
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
