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

    def update(*args)
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

      parts = self.name_seed.split(':')
      # The name generation system can return the same name when the input
      # values are changed by small amounts. Pairs 3, 4 and 5 are set by the
      # vendor for the specific interface and so it is possible (though
      # unlikely) to have devices with address that only change in pair 5.
      # The chance of duplicate names can be reduced by using pairs 0, 1 and 2
      # (representing the vendor) as the least significant parts.
      EliteUniverse::Planet.new(
        (parts[3] + parts[0]).to_i(16),
        (parts[4] + parts[1]).to_i(16),
        (parts[5] + parts[2]).to_i(16)
      ).name
    end

    def details
      {
        'application' => self.application
      }
    end

    def self.plugin_params params
      params.permit(:range, :user_agent, macs: [])
    end
  end
end
