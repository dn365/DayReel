class CreateBizs < ActiveRecord::Migration
  def change
    create_table :bizs do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :phone
      t.string :note
      t.integer :user_id

      t.timestamps
    end
  end
end
