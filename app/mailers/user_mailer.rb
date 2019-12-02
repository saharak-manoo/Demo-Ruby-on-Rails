class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def login_notification(user)
    @user = user
    mail(to: @user.email, subject: 'แจ้งเตือนการเข้าสู่ระบบ')
  end
end
