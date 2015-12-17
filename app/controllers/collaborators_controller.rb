class CollaboratorsController < ApplicationController
  before_action :set_wiki

  def index
    @users = User.all
  end

  def create
    @collaborator = @wiki.collaborators.new(user_id: params[:user_id])
    if @collaborator.save
      flash[:notice] = "Collaborator successfully added."
    else
      flash[:error] = "There was an error adding the collaborator. Please try again."
    end
    redirect_to wiki_collaborators_path(@wiki)
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "Collaborator successfully removed."
    else
      flash[:error] = "There was an error removing the collaborator. Please try again."
    end
    redirect_to wiki_collaborators_path(@wiki)
  end

  private
  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end
end
