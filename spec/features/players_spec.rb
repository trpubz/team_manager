require "rails_helper"

RSpec.describe "Players features" do
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

  describe "index page" do
    it "shows all the players" do
      visit "/players"

      expect(page).to have_content @p1.name
    end

    it "provides navigation to players index page from all other pages" do
      # As a league manager<br>
      #      When I visit any page on the site<br>
      #      Then I see a link at the top of the page that takes me to the Player Index<br>
      plyr_idx = "/players"
      visit "/teams"
      expect(page).to have_link(nil, href: plyr_idx)
      visit "/teams/#{@team1.id}"
      expect(page).to have_link(nil, href: plyr_idx)
      visit "/teams/#{@team1.id}/players"
      expect(page).to have_link(nil, href: plyr_idx)
      visit "/players/#{@p1.id}"
      expect(page).to have_link(nil, href: plyr_idx)
    end
  end

  describe "player pages" do
    it "shows all attributes of the player" do
      # As a league manager<br>
      #      When I visit '/players/:id'<br>
      #      Then I see the player with that id including the player's attributes<br>
      #      (data from each column that is on the player table)
      visit "/players/#{@p1.id}"

      expect(page).to have_content @p1.xwOBA
    end
  end
end
