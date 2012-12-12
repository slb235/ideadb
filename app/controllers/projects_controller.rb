class ProjectsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, :only => [:edit, :update, :show]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    @project.users << current_user
    if @project.save
      flash[:notice] = "Project created successful"
      redirect_to dashboard_path
    else
      render 'new'
    end
  end  

  def edit
    if params[:email]
      user = User.find_by_email(params[:email])
      if user
        @project.users << user
        @project.save
      else
        flash.now[:error] = "Could not find that address"
      end
    end
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project updated"
      redirect_to dashboard_path
    else
      render 'edit'
    end    
  end

  private
    def correct_user
      @project = Project.find_by_id(params[:id])
      unless @project.users.include? current_user
        flash[:warning] = "This is not ur project"
        redirect_to dashboard_path
      end 
    end

end
