require 'elite_universe/planet'

module HiveMindTv
  class Plugin < ActiveRecord::Base
    has_one :device, as: :plugin

    def self.create(*args)
      if args[0] and args[0].keys.include? 'macs'
        args[0]['name_seed'] = args[0]['macs'][0]
        args[0].delete('macs')
      end

      super(*args)
    end

    def name
      if ! self.name_seed
        if self.device and self.device.macs.length > 0
          self.name_seed = self.device.macs.first.mac
        else
          return "TV #{self.id}"
        end
      end

      w = []
      parts = self.name_seed.split(':')
      3.times do |i|
        w[i] = (parts[2*i] + parts[2*i + 1]).to_i(16)
      end

      EliteUniverse::Planet.new(*w).name
    end

    def self.plugin_params params
      params.permit(:range, :user_agent, macs: [])
    end
  end
end
