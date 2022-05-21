class TeamsController < ApplicationController
  before_action :set_team, only: %i[ edit update destroy ]

  def index
    @team = Team.new
    @teams = Team.all
  end

  def edit
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to teams_url, notice: "#{@team.name} was successfully created."
    else
      @teams = Team.all
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @team.update(team_params)
      redirect_to teams_url, notice: "#{@team.name} was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @team.discard

    redirect_to teams_url, notice: "#{@team.name} was successfully removed"
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name)
  end
end
