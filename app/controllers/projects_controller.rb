class ProjectsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, :only => [:edit, :update, :show, :rename_tag, :remove_user, :edit_style, :update_style, :destroy]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      @pu = ProjectUser.new :project => @project, :user => current_user
      @pu.save!
      flash[:notice] = "Project created successful"
      redirect_to dashboard_path
    else
      render 'new'
    end
  end  

  def rename_tag
    unless params[:to].empty?
      @project.ideas.tagged_with(params[:from]).each do |idea|
        idea.tag_list.remove params[:from]
        idea.tag_list.add params[:to]
        idea.save
      end
    end
    
    redirect_to project_ideas_path(@project)
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

  def edit_style
    @pu = @project.project_users.where(:user_id => current_user.id).first()
  end

  def update_style
    if ProjectUser.where(:user_id => current_user, :project_id => @project).update_all(params[:pu])
      flash[:notice] = "Project style updated"
      redirect_to dashboard_path
    else
      render 'edit_style'
    end    
  end


  def remove_user
    @project.users.delete(User.find(params[:user_id]))
    redirect_to edit_project_path(@project)
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project updated"
      redirect_to dashboard_path
    else
      render 'edit'
    end    
  end

  def destroy
    @project.destroy
    redirect_to dashboard_path
  end

  private
    def correct_user
      params[:project_id] = params[:id] unless params[:project_id]
      @project = Project.find_by_id(params[:project_id])
      unless @project.users.include? current_user
        flash[:warning] = "This is not ur project"
        redirect_to dashboard_path
      end 
    end

end
