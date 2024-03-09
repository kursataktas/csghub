class DailyPapersController < ApplicationController
  def index
    @daily_papers = DailyPaper.search_by(params[:keywords])
                              .order(published_at: :desc)
                              .page(params[:page]).per(9)
    @keywords = params[:keywords]
    @page = params[:page]
  end

  def new
    authorize DailyPaper
  end

  def show
    @daily_paper = DailyPaper.find_by!(uuid: params[:uuid])

    @model_data = []
    if @daily_paper.model_links.present?
      model_list_result = Starhub.api.models_by_paths @daily_paper.model_links
      @model_data = JSON.parse(model_list_result)['data']
    end
    @dataset_data = []
    if @daily_paper.dataset_links.present?
      dataset_list_result = Starhub.api.datasets_by_paths @daily_paper.dataset_links
      @dataset_data = JSON.parse(dataset_list_result)['data']
    end
  end
end
