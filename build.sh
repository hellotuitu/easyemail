rm easyemail-0.1.0.gem
git add --all
git commit --all -m "hello"
gem uninstall easyemail
gem build easyemail.gemspec
gem install easyemail-0.1.0.gem
