class MatchResultsController < ApplicationController
  before_action :set_match_result, only: %i[ show edit update destroy ]

  def index
    @match_results = MatchResult.all
  end

  def show
  end

  def new
    @teams = Team.all
    @match_result = MatchResult.new
  end

  def edit
    @teams = Team.all
  end

  def create
    @match_result = MatchResult.new(match_result_params)

    if @match_result.save
      redirect_to match_result_url(@match_result), notice: "Match result was successfully created."
    else
      @teams = Team.all
      render :new, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @match_result.update(match_result_params)
        redirect_to match_result_url(@match_result), notice: "Match result was successfully updated."
      else
        @teams = Team.all
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @match_result.destroy

    redirect_to match_results_url, notice: "Match result was successfully destroyed."
  end

  private

  def set_match_result
    @match_result = MatchResult.find(params[:id])
  end

  def match_result_params
    params.require(:match_result).permit(:home_team_id, :home_goals, :home_red_cards, :away_team_id, :away_goals, :away_red_cards, :result)
  end
end
