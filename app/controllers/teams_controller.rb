class TeamsController < ApplicationController
  def team_params
    params.permit(:name, :abbrv, :owner, :win_pct, :joined)
  end

  def id
    params[:id]
  end

  def index
    @teams = Team.all.order(created_at: :desc)
  end

  def show
    @team = Team.find(id)
  end

  def players
    # require 'pry'; binding.pry
    @team = Team.find(id)
    players = @team.players  # get all the players into temp var
    players = sorted(@team) if params[:sorted]  # overwrite if the sorted param is present
    players = filtered(@team) if params[:commit]  # overwrite if the filtered param is present
    @players = players
  end

  def filtered(tm)
    tm.players.filter_above(params.keys.first, params.values.first)
  end

  def sorted(tm)
    if params[:sorted] == "true"
      tm.players.sorted_by_name
    else
      tm.players
    end
  end

  def new
  end

  def create
    # require "pry"; binding.pry
    Team.create!(team_params)

    redirect_to "/teams"
  end

  def create_player
    @team = Team.find(id)
  end

  def add_new_player
    # require 'pry'; binding.pry
    Team.find(params[:id]).players.create!(
      name: params[:name],
      mlb_team: params[:mlb_team],
      pos: params[:pos],
      xwoba: params[:xwoba].empty? ? nil : params[:xwoba],
      xfip: params[:xfip].empty? ? nil : params[:xfip],
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

  def filter

  end
end
