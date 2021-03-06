class HomeController < ApplicationController
  # skip_before_filter :verify_authenticity_token, :only => [:login]
	protect_from_forgery

	layout 'application'

	before_filter :setSlideItem

	# Start of actions
	def index
		if current_user.nil?
			@user = User.new
		else
			@user = current_user
		end
	end

	def login
		email = params[:user][:email]
		password = params[:user][:password]

		user = User.authenticate_by_email(email, password)

		if user
			update_authentication_token(user, params[:user][:remember_me])
			user.save
			session[:user_id] = user.id
      redirect_to root_url
      # render json: {success: "ok"}
      # flash[:notice] = 'Hi ' + user.name + ', you logged in as ' + user.username
    else
      # respond_to do |format|
      #   format.html {render :login}
      #   format.js {render :layout => false}
      # end

      # flash[:error] = 'Unknown user. Please check your username and password.'
      render json: {error: "Unknown User #{email}. Please check your username and password."}
      # redirect_to root_url
    end
  end

	def register
		user = User.new(params[:user])

		if user.valid?
			update_authentication_token(user, params[:user][:remember_me])
			user.save
			UserMailer.welcome_email(user).deliver
			session[:user_id] = user.id
			flash[:notice] = 'Welcome.'
			redirect_to :root
		else
			# render :action => "new_user"
			redirect_to :root
		end
	end

	# Http put
	def send_password_reset_instructions
		email = params[:user][:email]

		user = User.find_by_email(email)


		if user
			user.password_reset_token = SecureRandom.urlsafe_base64
			user.password_expires_after = 24.hours.from_now
			user.save
			UserMailer.reset_password_email(user).deliver
			flash[:notice] = 'Password instructions have been mailed to you. Please check your inbox.'
			redirect_to :root
		else
			@user = User.new
			# put the previous value back.
			@user.email = params[:user][:email]
			@user.errors[:email] = ' is not a registered user.'
			redirect_to :root
		end
	end

	# HTTP get
	def password_reset
		token = params.first[0]
		@user = User.find_by_password_reset_token(token)

		if @user.nil?
			flash[:error] = 'You have not requested a password reset.'
			redirect_to :root
			return
		end

		if @user.password_expires_after < DateTime.now
			clear_password_reset(@user)
			@user.save
			flash[:error] = 'Password reset has expired. Please request a new password reset.'
			redirect_to :forgot_password
		end
	end

	# HTTP put
	def new_password
		username = params[:user][:username]
		@user = User.find_by_username(username)

		if verify_new_password(params[:user])
			@user.update_attributes(params[:user])
			@user.password = @user.new_password

			if @user.valid?
				clear_password_reset(@user)
				@user.save
				flash[:notice] = 'Your password has been reset. Please sign in with your new password.'
				redirect_to :sign_in
			else
				render :action => "password_reset"
			end
		else
			@user.errors[:new_password] = 'Cannot be blank and must match the password verification.'
			render :action => "password_reset"
		end
	end

	def sign_out
		user = User.find_by_id(session[:user_id])
		if user
			update_authentication_token(user, nil)
			user.save
			session[:user_id] = nil
			flash[:notice] = "You have been signed out."
			# current_user = nil
		end
		redirect_to :root
	end

	# End of actions

	def authenticate_user
		if current_user.nil?
			flash[:error] = 'You must be signed in to view that page.'
			redirect_to :root
		end
	end

	def update_authentication_token(user, remember_me)
		if remember_me.to_i == 1
			# create an authentication token if the user has clicked on remember me
			auth_token = SecureRandom.urlsafe_base64
			user.authentication_token = auth_token
			cookies.permanent[:auth_token] = auth_token
		else # nil or 0
			# if not, clear the token, as the user doesn't want to be remembered.
			user.authentication_token = nil
			cookies.permanent[:auth_token] = nil
			# current_user = nil
		end
	end

	def setSlideItem
		@curSlideItem = 'home'
	end
end

