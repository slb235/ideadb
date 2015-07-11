class Idea < ActiveRecord::Base
  attr_accessible :title, :project_id
  belongs_to :project
  belongs_to :user

  has_many :comments

  after_create :send_notifications

  acts_as_taggable

  def as_json(options={})
    super(:include => [:tags, :user, :comments])
  end

  def send_notifications
    project.project_users.each do |pu|
      unless pu.user == user
        if pu.sms_notify
          unless pu.user.phone.empty?
            Ideadb.send_sms pu.user.phone, "#{user.name} added an idea to #{project.title}"
          end
        end
        if pu.email_notify
          UserMailer.idea_notify(self, pu.user).deliver
        end
      end
    end 
  end
end
