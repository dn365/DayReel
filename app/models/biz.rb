class Biz < ActiveRecord::Base
  #belongs_to :user
  attr_accessible :company_name, :address, :city, :phone, :biz_type, :url, :rate, :state, :email
end
