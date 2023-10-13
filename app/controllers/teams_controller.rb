class TeamsController < ApplicationController
  def index
    @teams = Team.all.order(created_at: :desc)
  end

  def show
    @team = Team.find(params[:id])
  end

  def players
    @team = Team.find(params[:id])
    @players = @team.players
  end

  def new
  end

  def create
    # require "pry"; binding.pry
    Team.create!(
      name: params[:name],
      abbrv: params[:abbrv],
      owner: params[:owner],
      win_pct: params[:win_pct],
      joined: true
    )

    redirect_to "/teams"
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    Team.find(params[:id]).update!(
      name: params[:team][:name],
      abbrv: params[:team][:abbrv],
      owner: params[:team][:owner],
      win_pct: params[:team][:win_pct],
      joined: params[:team][:joined] == "1"
    )

    redirect_to "/teams/#{params[:id]}"
  end
end
