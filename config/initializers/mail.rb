ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "activemailertester66@gmail.com",
  :password             => "testactivemailer",
  :authentication       => "plain",
  :enable_starttls_auto => true
}