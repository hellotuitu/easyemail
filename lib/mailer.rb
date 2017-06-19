class Easyemail
  require 'active_support'
  require 'action_mailer'

  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.view_paths = File.dirname(__FILE__)

  class Mailer < ActionMailer::Base
    def send_email from, to, subject, content
      @content = content
      mail(
        to: to,
        from: from,
        subject: subject
      ) do | format |
        format.html
      end
    end
  end
end
