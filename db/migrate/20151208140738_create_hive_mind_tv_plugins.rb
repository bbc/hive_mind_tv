class CreateHiveMindTvPlugins < ActiveRecord::Migration
  def change
    create_table :hive_mind_tv_plugins do |t|
      t.string :range
      t.string :user_agent
      t.string :name_seed

      t.timestamps null: false
    end
  end
end
