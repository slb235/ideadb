class StaticPagesController < ApplicationController
  before_filter :signed_in_user, :only => :dash

  def home
    redirect_to signin_path unless signed_in?
    redirect_to dashboard_path if signed_in?
  end

  def help
  end

  def dash
    @projects = current_user.projects
  end
end
