require "rails_helper"

RSpec.describe Team do
  before(:each) do
    @team1 = Team.create!(name: "Julio's Juice Box Boys", abbrv: "PEWB", owner: "TP", win_pct: 0.5595, joined: true)
    @team2 = Team.create!(name: "Campus Popo", abbrv: "POPO", owner: "Dave P", win_pct: 0.5238, joined: true)
    @team3 = Team.create!(name: "Pablo Sanchez's", abbrv: "DIRT", owner: "Tanner P", win_pct: 0.4940, joined: true)
    @p1 = @team1.players.create!(name: "Julio Rodriquez",
      mlb_team: "SEA",
      pos: "OF",
      xwoba: 0.346,
      xfip: nil,
      injured: false)
    @p2 = @team2.players.create!(name: "Aaron Judge",
      mlb_team: "NYY",
      pos: "OF",
      xwoba: 0.468,
      xfip: nil,
      injured: true)
    @p4 = @team1.players.create!(name: "Trea Turner",
      mlb_team: "PHI",
      pos: "SS",
      xwoba: 0.330,
      injured: false)
    @p5 = @team1.players.create!(name: "Randy Arozarena",
      mlb_team: "TB",
      pos: "OF",
      xwoba: 0.352,
      injured: false)
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

  describe "filtering methods" do
    describe "#filter_above" do
      it "takes column name and value and returns results" do
        expect(Player.filter_above(:xwOBA, 0.352)).to eq [@p2, @p5]
      end
    end
  end
end
