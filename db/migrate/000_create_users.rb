class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :email
			t.string :hashed_password
			t.string :salt
			t.string :first_name
			t.string :last_name
			t.date :birthday
			t.string :street
			t.string :city
			t.string :state
			t.string :zip
			t.string :phone
			t.string :phone_type
			t.string :password_reset_token
			t.datetime :password_expires_after
			t.string :authentication_token

			t.timestamps
		end
	end
end
