class PlayersController < ApplicationController
  def id
    params[:id]
  end

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
      xwoba: params[:player][:xwoba],
      xfip: params[:player][:xfip],
      injured: params[:player][:injured] == "1"
    )
    redirect_to "/players/#{id}"
  end

  def destroy
    Player.find(id).destroy!

    redirect_to "/players"
  end
end
