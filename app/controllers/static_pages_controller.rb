class StaticPagesController < ApplicationController
  before_filter :signed_in_user, :only => :dash

  def home
  end

  def help
  end

  def dash
    @projects = current_user.projects
  end
end
