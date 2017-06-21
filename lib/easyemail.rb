require "easyemail/version"
require "mailer"

class Easyemail
  require "yaml"

  attr_accessor :to

  @@config = YAML.load_file(File.dirname(__FILE__) + "/easyemail/smtp.yml")
  @@support = []
  @@config.each do | key, value|
    # generate methods
    @@support.push key
    define_method "smtp_settings_for_#{key}" do | p1, p2|
      value["user_name"] = p1
      value["password"] = p2
      self.smtp_settings value
    end
  end

  def load_smtp_settings_from_yaml path
    smtp = YAML.load_file(path)
    if smtp["provider"]
      # 如果指定了邮件服务商 就直接跳转到该服务商
      self.send("smtp_settings_for_#{smtp["provider"]}", smtp["user_name"], smtp["password"])
    else
      self.smtp_settings smtp
    end
  end

  def smtp_settings smtp
    # common settings for smtp, all provided by user.
    begin
      ActionMailer::Base.smtp_settings = Hash[smtp.keys.collect!{ | e | e.to_sym }.zip smtp.values]
      @from = smtp["user_name"]
      @config = true
    rescue
      raise "wrong parameters for smtp settings."
    end
  end

  def email subject, content
    # content支持html
    if @config && @to
      if @to.respond_to? :each
        @to.each do | e |
          Mailer.send_email(@from, e, subject, content).deliver
        end
      else
        Mailer.send_email(@from, @to, subject, content).deliver
      end
    else
      raise "check smtp_settings and receiver!"
    end
  end

  def support
    @@support
  end
end
