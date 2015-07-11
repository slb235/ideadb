class UserMailer < ActionMailer::Base
  default from: "no-reply@noplu.de"

  def new_pw(new_pw, user)
    @new_pw = new_pw
    mail(:to => user.email, :subject => 'IdeaDB: Your new password')
  end

  def idea_notify(idea, user)
    @idea = idea
    @user = user
    mail(:to => user.email, :subject => "IdeaDB: #{user.name} added an idea to #{idea.project.title}")
  end
end
