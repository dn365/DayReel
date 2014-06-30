class AddUrlToBizs < ActiveRecord::Migration
  def change
    add_column :bizs, :url, :string
  end
end
