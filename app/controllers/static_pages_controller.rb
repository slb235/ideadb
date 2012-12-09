class StaticPagesController < ApplicationController
  before_filter :signed_in_user, :only => :dash

  def home
  end

  def help
  end

  def dash
  end
end
