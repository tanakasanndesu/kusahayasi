class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  default_url_options[:host] = 'host_name.com'
  layout 'mailer'
end
