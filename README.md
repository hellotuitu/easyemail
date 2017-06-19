# Easyemail

Easyemail可以极大的简化发送邮件的过程.

## Installation

`gem install easyemail -v 1.0.0`

## Usage

### 第一步:设置smtp

该gem内部为一些知名的邮件服务商提供了预设置, 查看支持的邮件服务商的代码如下:
```ruby
  mailer = Easyemail.new
  mailer.support
  # 该方法返回一个支持的邮件服务商组成的数组
  #ｅ.g: ["163", "qq", "hhu", "gmail"]
```

对于任何一个支持的邮件服务商，可以使用便捷的smtp设置方法：
```ruby
  mailer.smtp_settings_for_*** user_name, password
  # e.g:
  #   smtp_settings_for_163
  #   smtp_settings_for_qq
  # 确保使用的账号开通了smtp服务
  # username 和 password 是该邮箱账号(账号包括完整后缀)和密码(smtp服务密码)
```

如果你使用的邮箱账号不在支持列表中,设置方法如下:
```ruby
# 确保该账号开通了smtp服务
# username 和 password 是你的邮箱账号(账号包括完整后缀)和密码
  mailer = Easyemail.new
  smtp = {
    "address" => "**",
    "port" => **,
    "authentication" => "**",
    "user_name" => "**",
    "password" => "**",
    "enable_starttls_auto" => **
  }
  mailer.smtp_settings smtp
```

另外,还可以从yaml配置文件中导入smtp信息,同样的,如果邮件服务商被支持,配置文件可以这样写
```
provider: ** # (只能从support方法返回的数组中选择)
user_name: **
password: **
```
否则配置文件需这样写:
```
address: **
port: **
authentication: **
user_name: **
password: **
enable_starttls_auto: **
```

调用代码如下:
```ruby
  mailer = Easyemail.new
  mailer.load_smtp_settings_from_yaml file_path
```

### 第二步:设置收件人

允许群发邮件, 设置收件人代码如下:
```ruby
  mailer.to = "someone@**.com" # 单收件人
  mailer.to = ["someone@**.com", "**"] # 多收件人
```

### 第三步:发送邮件

邮件内容支持文本和html格式,两者都以字符串的形式作为参数,调用代码如下:
```ruby
# subject是邮件主题, content是邮件内容
  mailer.email(subject, content)
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
