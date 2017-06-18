require "easyemail/version"

class Easyemail
  require 'active_support'
  require 'action_mailer'
  require "yaml"

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

  def load_smtp_settings_from_yaml path
    smtp = YAML.load_file(path)
    if smtp["provider"]
      # 如果指定了是谁家的邮箱 待选列表 163, hhu, qq, gmail
      self.send("smtp_settings_for_#{smtp["provider"]}", smtp)
    else
      self.smtp_settings smtp
    end
  end

  def smtp_settings smtp
    # common settings for smtp, all provided by user.
    begin
      ActionMailer::Base.smtp_settings = smtp #{
      #   address: smtp['adress'],
      #   port: smtp["port"],
      #   authentication: smtp["authentication"],
      #   user_name: smtp['user_name'],
      #   password: smtp['password'],
      #   enable_starttls_auto: smtp["enable_starttls_auto"]
      # }
      @from = smtp["user_name"]
      @config = true
    rescue
      raise "wrong parameters for smtp settings."
    end
  end

  def to= to
    # 支持群发
    @to = to
  end

  def email subject, title, content
    # content支持html

    if @config && @to
      if @to.respond_to? :each
        @to.each do | e |
          Mailer.send_email(@from, e, subject, title, content).deliver
        end
      else
        Mailer.send_email(@from, @to, subject, title, content).deliver
      end
    else
      raise "check smtp_settings and receiver!"
    end
  end

  def smtp_settings_for_163 user_name, password
    smtp = {
      "address" => "smtp.163.com",
      "port" => 25,
      "authentication" => "login",
      "user_name" => user_name,
      "password" => password,
      "enable_starttls_auto" => true
    }
    self.smtp_settings smtp
  end

  def smtp_settings_for_hhu user_name, password
    smtp = {
      "address" => "mail.hhu.edu.cn",
      "port" => 25,
      "authentication" => "login",
      "user_name" => user_name,
      "password" => password,
      "enable_starttls_auto" => false
    }
    self.smtp_settings smtp
  end

  def smtp_settings_for_qq user_name, password
    smtp = {
      "address" => "smtp.qq.com",
      "port" => 25,
      "authentication" => "login",
      "user_name" => user_name,
      "password" => password,
      "enable_starttls_auto" => false
    }
    self.smtp_settings smtp
  end

  def smtp_settings_for_gmail user_name, password
    smtp = {
      "address" => "smtp.gmail.com",
      "port" => 587,
      "authentication" => "login",
      "user_name" => user_name,
      "password" => password,
      "enable_starttls_auto" => true
    }
    self.smtp_settings smtp
  end
end
