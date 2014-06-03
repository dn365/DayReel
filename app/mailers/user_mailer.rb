class UserMailer < ActionMailer::Base
	default :from => "webmaster@dayreel.com"

	def welcome_email(user)
		@user = user
		@url = "http://dayreel.herokuapp.com/"
		@site_name = "DayReel"
		mail(:to => user.email, :subject => "Welcome to my website.")
	end

	def reset_password_email(user)
		@user = user
		@password_reset_url = 'http://dayreel.herokuapp.com/password_reset?' + @user.password_reset_token
		mail(:to => user.email, :subject => 'Password Reset Instructions.')
	end
end
