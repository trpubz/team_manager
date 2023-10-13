class TeamsController < ApplicationController
  def index
    @teams = Team.all.order(created_at: :desc)
  end

  def show
    @team = Team.find(params[:id])
  end

  def players
    # require 'pry'; binding.pry
    @team = Team.find(params[:id])
    @players = if params[:sorted].nil?
      @team.players
    else
      @team.players.sorted_by_name
    end
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

  def create_player
    @team = Team.find(params[:id])
  end

  def add_new_player
    # require 'pry'; binding.pry
    Team.find(params[:id]).players.create!(
      name: params[:name],
      mlb_team: params[:mlb_team],
      pos: params[:pos],
      xwOBA: params[:xwoba].empty? ? nil : params[:xwoba],
      xFIP: params[:xfip].empty? ? nil : params[:xfip],
      injured: params[:injured] == "1"
    )

    redirect_to "/teams/#{params[:id]}/players"
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

  def destroy
    Team.find(params[:id]).destroy!

    redirect_to "/teams"
  end
end
