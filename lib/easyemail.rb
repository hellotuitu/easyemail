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
      port: smtp["port"],
      authentication: smtp["authentication"],
      user_name: smtp['user_name'],
      password: smtp['user_password'],
      enable_starttls_auto: smtp["ttl"]
    }
    @config = true
  end

  def from= from
    @from = from
  end

  def to= to
    @to = to
  end

  def email subject, title, content
    if @config && @from && @to
      Mailer.send_email(@from, @to, subject, title, content).deliver
    else
      raise "check smtp_settings, from, to!"
    end
  end

  def smtp_settings_for_163 user_name, user_password
    ActionMailer::Base.smtp_settings = {
      address: "smtp.163.com",
      port: 25,
      authentication: "login",
      user_name: user_name,
      password: user_password,
      enable_starttls_auto: true
    }
    @config = true
  end

  def smtp_settings_for_hhu user_name, user_password
    ActionMailer::Base.smtp_settings = {
      address: "mail.hhu.edu.cn",
      port: 25,
      authentication: "login",
      user_name: user_name,
      password: user_password,
      enable_starttls_auto: false
    }
    @config = true
  end

  def smtp_settings_for_qq user_name, user_password
    ActionMailer::Base.smtp_settings = {
      address: "smtp.qq.com",
      port: 25,
      authentication: "login",
      user_name: user_name,
      password: user_password,
      enable_starttls_auto: false
    }
    @config = true
  end

  def smtp_settings_for_gmail user_name, user_password
    ActionMailer::Base.smtp_settings = {
      address: "smtp.gmail.com",
      port: 587,
      authentication: "plain",
      user_name: user_name,
      password: user_password,
      enable_starttls_auto: true
    }
    @config = true
  end
end
