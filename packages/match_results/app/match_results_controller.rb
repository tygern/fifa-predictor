class MatchResultsController < ApplicationController
  def index
    @teams = Team.all
    @match_result = MatchResult.new(
      duration: 90,
      home_goals: 0,
      home_red_cards: 0,
      away_goals: 0,
      away_red_cards: 0,
    )

    @match_results = match_results
  end

  def create
    @match_result = MatchResult.new(match_result_params)

    if @match_result.save
      redirect_to match_result_url(@match_result), notice: "Match result was successfully created."
    else
      @teams = Team.all
      @match_results = match_results
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    match_result = MatchResult.find(params[:id])
    match_result.discard

    redirect_to match_results_url, notice: "Match result was successfully destroyed."
  end

  private

  def match_results
    MatchResult.all.map do |match_result|
      MatchResultPresenter.new(match_result)
    end
  end

  def match_result_params
    params.require(:match_result).permit(:home_team_id, :home_goals, :home_red_cards, :away_team_id, :away_goals, :away_red_cards, :duration)
  end
end
