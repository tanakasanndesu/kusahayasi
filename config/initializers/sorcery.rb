Rails.application.config.sorcery.submodules = [:reset_password]

Rails.application.config.sorcery.configure do |config|
  config.user_class = "User"
  config.user_config do |user| 
    user.reset_password_mailer = UserMailer
    user.stretches = 1 if Rails.env.test?
  end  
end 
