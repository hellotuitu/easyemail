# Easyemail

Easyemail是一个为简化邮件发送流程而发布的gem.

## Installation

下载位于项目根目录下的gem安装包`easyemail-0.1.0.gem`

执行命令`gem install easyemail-0.1.0.gem`

## Usage

### 第一步:设置smtp

该gem为三个知名的邮件服务商`163.com qq.com gmail.com`和我学校(HHU)的邮箱服务做了预先的设置,如果你用来发送邮件的账号来自于以上的邮件服务商,设置smtp的方法如下:
```ruby
# 以163邮箱为例
# 确保该账号开通了smtp服务
# username 和 password 是你的邮箱账号(账号包括完整后缀)和密码
  mailer = Easyemail.new
  mailer.smtp_settings_for_163  user_name, password
# 同样的方法还有:
#   smtp_settings_for_hhu
#   smtp_settings_for_qq
#   smtp_settings_for_gmail
```

如果你使用的不是以上任何一种,设置方法如下:
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

另外,还可以从yaml配置文件中导入smtp信息,同样的,如果来自以上四个邮件服务商,配置文件可以这样写
```
provider: ** # (只能从163, qq, gmail, hhu中任选一个)
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
