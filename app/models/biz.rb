class Biz < ActiveRecord::Base
  #belongs_to :user
  attr_accessible :name, :address, :city, :phone, :note, :url, :rate
end
