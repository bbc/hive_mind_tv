class AddApplicationToHiveMindTvPlugin < ActiveRecord::Migration
  def change
    add_column :hive_mind_tv_plugins, :application, :string
  end
end
