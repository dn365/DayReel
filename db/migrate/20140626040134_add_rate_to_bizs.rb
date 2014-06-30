class AddRateToBizs < ActiveRecord::Migration
  def change
    add_column :bizs, :rate, :string
  end
end
