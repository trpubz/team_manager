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
    Team.create!(name: params[:name],
      abbrv: params[:abbrv],
      owner: params[:owner],
      win_pct: params[:win_pct],
      joined: true)

    redirect_to "/teams"
  end
end
