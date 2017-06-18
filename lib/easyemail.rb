require "easyemail/version"
require 'active_support'
require 'action_mailer'

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.view_paths = File.dirname(__FILE__)

class MyMailer < ActionMailer::Base
  def send_email from, to, subject, title, content
    p "dsfsdfssaaaaaaaaaaaaaaaa"
    @content = content
    @title = title
    mail(
      to: to,
      from: from,
      subject: subject
    ) do | format |
      format.html
    end

    p "hellosss"
  end
end

class Easyemail

  def initialize

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
    @subject = subject
    @title = title
    @content = content

    Mailer.send_email(@from, @to, @subject, @title, @content)
    p "dsfsdfsd"
  end
  def self.hello
    p "hi"
  end
end
