require "rails_helper"

RSpec.describe Team do
  before(:each) do
    @team1 = Team.create!(name: "Julio's Juice Box Boys", abbrv: "PEWB", owner: "TP", win_pct: 0.5595, joined: true)
    @team2 = Team.create!(name: "Campus Popo", abbrv: "POPO", owner: "Dave P", win_pct: 0.5238, joined: true)
    @team3 = Team.create!(name: "Pablo Sanchez's", abbrv: "DIRT", owner: "Tanner P", win_pct: 0.4940, joined: true)
    @p1 = @team1.players.create!(name: "Julio Rodriquez",
      mlb_team: "SEA",
      pos: "OF",
      xwOBA: 0.346,
      xFIP: nil,
      injured: false)
    @p2 = Player.create!(name: "Aaron Judge",
      mlb_team: "NYY",
      pos: "OF",
      xwOBA: 0.468,
      xFIP: nil,
      injured: true)
  end

  describe "aggregation methods" do
    describe "#counts" do
      it "counts the player associations" do
        # As a league manager<br>
        #      When I visit a team's show page<br>
        #      I see a count of the number of players associated with this team<br>
        expect(@team1.count_players).to eq 1
      end
    end
  end
end
