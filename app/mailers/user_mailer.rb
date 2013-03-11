class UserMailer < ActionMailer::Base
  default from: "no-reply@noplu.de"

  def new_pw(new_pw, user)
    @new_pw = new_pw
    mail(:to => user.email, :subject => 'Your new Ideaddb password')
  end
end
