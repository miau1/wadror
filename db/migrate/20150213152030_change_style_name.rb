class ChangeStyleName < ActiveRecord::Migration
  def self.up
    rename_column :beers, :style, :old_style
  end
end