class ApiController < ApplicationController

	protect_from_forgery

	def auth_with_email
		email = params[:email]
		password = params[:password]
		remember_me = params[:remember_me]
		# puts "remember me is " + remember_me

		if email.nil? || password.nil?
			render json: {result: false, data:{message: "Email and password should not be empty"}}
		else
			user = User.authenticate_by_email(email, password)
			if user.nil?
				render json: {result: false, data: {message: "Email or password is incorrect"}}
			else
				update_authentication_token(user, remember_me)
				render json: {result: true, data: {token: user.authentication_token, message: "Welcome!"}}
			end
		end
	end

	def auth_with_token
		token = params[:token]

		user = User.authenticate_by_token(token)
		if user.nil?
			render json: {result: false, data: {message: "Token is invalid."}}
		else
			render json: {result: true, data: {token: user.authentication_token, message: "Welcome!"}}
		end
	end

	def update_authentication_token(user, remember_me)
		if remember_me.to_i == 1
			# create an authentication token if the user has clicked on remember me
			auth_token = SecureRandom.urlsafe_base64
			user.authentication_token = auth_token
			puts "==================="
			puts auth_token
			puts "==================="
			user.save
			cookies.permanent[:auth_token] = auth_token
		else # nil or 0
			# if not, clear the token, as the user doesn't want to be remembered.
			user.authentication_token = nil
			cookies.permanent[:auth_token] = nil
			# current_user = nil
		end
	end
end
