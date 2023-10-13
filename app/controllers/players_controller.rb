class PlayersController < ApplicationController
  def index
    @players = Player.healthy?
  end

  def show
    @player = Player.find(params[:id])
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    Player.find(params[:id]).update!(
      name: params[:player][:name],
      mlb_team: params[:player][:mlb_team],
      pos: params[:player][:pos],
      xwOBA: params[:player][:xwOBA],
      xFIP: params[:player][:xFIP],
      injured: params[:player][:injured] == "1"
    )
    redirect_to "/players/#{params[:id]}"
  end
end
