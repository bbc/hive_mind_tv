module HiveMindTv
  class Engine < ::Rails::Engine
    isolate_namespace HiveMindTv

    config.generators do |g|
      g.test_framework :rspec
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end

    initializer :assets do |app|
      app.config.assets.precompile += %w( hive_mind_tv.js )
    end
  end
end
