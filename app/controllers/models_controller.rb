class ModelsController < ApplicationController
  def index
  end

  def new_index
  end

  def show
    @model = Starhub.api.get_model_detail(params[:user_name], params[:model_name])
    @files = Starhub.api.get_model_files(params[:user_name], params[:model_name])
    @last_commit = Starhub.api.get_last_commit(params[:user_name], params[:model_name])
    @branches = Starhub.api.get_model_branches(params[:user_name], params[:model_name])
  end
end
