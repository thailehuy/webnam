ActionMailer::Base.smtp_settings = {
	:address => "smtp.gmail.com",
	:port => 587,
	:authentication => :plain,
  :enable_starttls_auto => true,
  :domain => "noreply@webnam.net.vn",
  :user_name => "noreply@webnam.net.vn",
  :password => "sZzrCW7F"
}