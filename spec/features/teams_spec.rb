require "rails_helper"

RSpec.describe "Teams features" do
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
    it "lands on a teams index and shows all the teams" do
      # For the team table<br>
      #      As a league manager<br>
      #      When I visit '/teams'<br>
      #      Then I see the name of each team record in the models<br>
      visit "/teams"

      expect(page).to have_content @team1.name
    end

    it "displays the teams with a sort by last created column" do
      # As a league manager<br>
      #      When I visit the team index,<br>
      #      I see that records are ordered by most recently created first<br>
      #      And next to each of the records I see when it was created<br>
      visit "/teams"

      expect(@team2.name).to appear_before @team1.name
    end

    it "provides a link to the teams index page from all other pages" do
      # As a league manager<br>
      #      When I visit any page on the site<br>
      #      Then I see a link at the top of the page that takes me to the Team Index<br>
      teams_idx_path = "/teams"
      visit "/players"
      expect(page).to have_link(nil, href: teams_idx_path)
      visit "/teams/#{@team1.id}"
      expect(page).to have_link(nil, href: teams_idx_path)
      visit "/teams/#{@team1.id}/players"
      expect(page).to have_link(nil, href: teams_idx_path)
      visit "/players/#{@p1.id}"
      expect(page).to have_link(nil, href: teams_idx_path)
    end
  end

  describe "team show page" do
    it "shows the team's attributes when at the team page" do
      # As a league manager<br>
      #      When I visit '/teams/:id'<br>
      #      Then I see the team with that id including the team's attributes<br>
      #      (data from each column that is on the team table)
      visit "/teams/#{@team1.id}"

      expect(page).to have_content @team1.win_pct.round(3)
      expect(page).to have_content "Joined: Yes"
    end

    it "shows the number of players on that team" do
      visit "/teams/#{@team1.id}"

      expect(page).to have_content "Player Count: #{@team1.count_players}"
    end

    it "links to team's player page" do
      team_show_page_path = "/teams/#{@team1.id}"
      visit team_show_page_path

      expect(page).to have_link(nil, href: team_show_page_path + "/players")
    end
  end

  describe "team's players page" do
    it "shows the team's players" do
      # As a league manager<br>
      #      When I visit '/teams/:team_id/players'<br>
      #      Then I see each Player that is associated with that Team with each Player's attributes<br>
      #      (data from each column that is on the player table)
      visit "/teams/#{@team1.id}/players"

      expect(page).to have_content @team1.players.first.name
    end
  end
end
