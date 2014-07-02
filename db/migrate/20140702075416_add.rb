class Add < ActiveRecord::Migration
  def up
    add_column :bizs, :biz_type, :string
    add_column :bizs, :state, :string
    add_column :bizs, :email, :string
    rename_column :bizs, :name, :company_name
    remove_column :bizs, :note
  end

  def down
    remove_column :bizs, :biz_type
    remove_column :bizs, :state
    remove_column :bizs, :email
    rename_column :bizs, :company_name, :name
    add_column :bizs, :note, :string
  end
end
