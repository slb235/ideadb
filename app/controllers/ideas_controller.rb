class IdeasController < ApplicationController
  def index
    @project = Project.find_by_id(params[:project_id])
    @ideas = @project.ideas

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @ideas }
    end
  end


  def show
    @idea = Idea.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @idea }
    end
  end

  def new
    @idea = Idea.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @idea }
    end
  end


  def edit
    @idea = Idea.find(params[:id])
  end


  def create
    @idea = Idea.new(params[:idea])


    respond_to do |format|
      if @idea.save
        format.html { redirect_to project_idea_path(@idea.project, @idea), :notice => 'Idea was successfully created.' }
        format.json { render :json => @idea, :status => :created, :location => project_idea_path(@idea.project, @idea) }
      else
        format.html { render :action => "new" }
        format.json { render :json => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @idea = Idea.find(params[:id])

    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        format.html { redirect_to project_idea_path(@idea.project, @idea), :notice => 'Idea was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @project = @idea.project
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to project_ideas_path(@project) }
      format.json { head :no_content }
    end
  end
end
