class User < ActiveRecord::Base

	# attr_accessible :first_name, :last_name, :email, :birthday, :password, :password_confirmation, :new_password, :new_password_confirmation, :remember_me

	# attr_accessor	:first_name, :last_name, :email, :password, :password_confirmation, :new_password, :new_password_confirmation, :remember_me
	attr_accessible :password, :remember_me, :first_name, :last_name, :email, :authentication_token
	attr_accessor :password, :remember_me, :authentication_token
	before_save		:encrypt_password

	# Validations.
	# regular expression for email validation
	EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

	validates :email, :presence => true, :length => {:maximum => 200}, :uniqueness => true, :format => EMAIL_REGEX
	# validates :new_password,	:confirmation => { :if => Proc.new {|user| !user.new_password.nil? && !user.new_password.empty? } }

	def self.authenticate_by_email(email, password)
		user = find_by_email(email)
		if user && user.hashed_password == BCrypt::Engine.hash_secret(password, user.salt)
			user
		else
			nil
		end
	end

	def self.authenticate_by_token(token)
		user = find_by_authentication_token(token)
		if user.nil?
			nil
		else
			user
		end
	end
	
	def initialize(attributes = {})
		super # must allow the active record to initialize!
		attributes.each do |name, value|
			send("#{name}=", value)
		end
	end

	def encrypt_password
		if password.present?
			self.salt = BCrypt::Engine.generate_salt
			self.hashed_password = BCrypt::Engine.hash_secret(password, salt)
		end
	end

  #has_many :bizs
end
