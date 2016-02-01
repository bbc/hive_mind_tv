module HiveMindTv
  class Plugin < ActiveRecord::Base
    @@chars = '..lexegezacebisousesarmaindirea.eratenberalavetiedorquanteisrion'.scan(/../)

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

    # TV naming inspired by Elite by Acornsoft
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

      name = ''
      l = ( w[0] & 64 )
      4.times do |i|
        if i < 3 or l > 0
          n = ( w[2] >> 8 ) & 31
          name += @@chars[n]
        end
        (w << ( ( w[0] + w[1] + w[2] ) % 65536 ) ).shift
      end
      name.gsub('.','').capitalize
    end

    def self.plugin_params params
      params.permit(:range, :user_agent, macs: [])
    end
  end
end
