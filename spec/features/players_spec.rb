require "rails_helper"

RSpec.describe "Players features" do
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
      injured: true,
      team_id: @team1.id)
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

    describe "edit button in players table" do
      it "has an edit button that takes user to edit page" do
        # As a league manager<br>
        #     When I visit the `players` index page or a team `players` index page<br>
        #     Next to every player, I see a link to edit that player's info<br>
        #     When I click the link<br>
        #     I should be taken to that `players` edit page where I can update its information just like in User Story 14
        visit "/players"

        click_on "plyr#{@p1.id}"

        expect(page).to have_current_path "/players/#{@p1.id}/edit"
      end
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

    describe "player updates" do
      # As a league manager
      #     When I visit a Player Show page<br>
      #     Then I see a link to update that Player "Update Player"<br>
      #     When I click the link<br>
      #     I am taken to '/players/:id/edit' where I see a form to edit the player's attributes:<br>
      #     When I click the button to submit the form "Update Player"<br>
      #     Then a `PATCH` request is sent to '/players/:id',
      #     the player's data is updated,
      #     and I am redirected to the Player Show page where I see the Player's updated information
      it "allows user to update player" do
        visit "/players/#{@p1.id}"

        expect(page).to have_button "Update Player"
      end

      it "shows current attributes and allows saving those changes" do
        visit "/players/#{@p1.id}/edit"

        fill_in("MLB Team", with: "ARI")

        click_button "Update Player"

        expect(page).to have_current_path "/players/#{@p1.id}"

        expect(page).to have_content "Team: ARI"
      end
    end

    describe "delete players" do
      # As a visitor
      #     When I visit a player show page
      #     Then I see a link to delete the player "Delete Player"
      #     When I click the link
      #     Then a 'DELETE' request is sent to '/players/:id',
      #     the player is deleted,
      #     and I am redirected to the player index page where I no longer see this player
      it "removes player from database" do
        visit "/players/#{@p1.id}"

        click_button "Delete Player"

        expect(page).to have_current_path "/players"
      end
    end
  end

  describe "displays records according to boolean values" do
    it "shows only healthy players" do
      # As a league manager<br>
      #     When I visit the player index<br>
      #     Then I only see records where the boolean column is `false`<br>
      visit "/players"

      within_table("players") do
        expect(page).to have_no_content "Yes"
      end
    end
  end
end
