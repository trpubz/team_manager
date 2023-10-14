require "rails_helper"

RSpec.describe Player do
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
    @p2 = Player.create!(name: "Aaron Judge",
      mlb_team: "NYY",
      pos: "OF",
      xwoba: 0.468,
      xfip: nil,
      injured: true)
  end

  describe "instance methods" do
    describe "healthy?" do
      it "returns all healthy players" do
        expect(Player.healthy?).to eq [@p1]
      end
    end

    describe "sort_by_name" do
      it "sorts players alphabetically" do
        expect(Player.sorted_by_name).to eq [@p2, @p1]
      end
    end
  end
end
