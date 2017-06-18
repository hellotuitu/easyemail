require "easyemail/version"

class Easyemail
  require 'active_support'
  require 'action_mailer'

  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.view_paths = File.dirname(__FILE__)

  class Mailer < ActionMailer::Base
    def send_email from, to, subject, title, content
      @content = content
      @title = title
      mail(
        to: to,
        from: from,
        subject: subject
      ) do | format |
        format.html
      end
    end
  end

  def smtp_settings smtp
    ActionMailer::Base.smtp_settings = {
      address: smtp['smtp'],
      port: 25,
      authentication: :login,
      user_name: smtp['user_name'],
      password: smtp['user_password'],
      enable_starttls_auto: false
    }
  end

  def from= from
    @from = from
  end

  def to= to
    @to = to
  end

  def email subject, title, content
    Mailer.send_email(@from, @to, subject, title, content).deliver
  end
end
