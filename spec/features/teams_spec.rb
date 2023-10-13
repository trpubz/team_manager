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
      injured: true,
      team_id: @team1.id)
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

    describe "new team button" do
      # As a league manager<br>
      #     When I visit the Team Index page<br>
      #     Then I see a link to create a new Team record, "New Team"<br>
      #     When I click this link<br>
      #     Then I am taken to '/teams/new' where I  see a form for a new team record<br>
      #     When I fill out the form with a new team's attributes:<br>
      #     And I click the button "Create Team" to submit the form<br>
      #     Then a `POST` request is sent to the '/teams' route,
      #     a new team record is created,
      #     and I am redirected to the Team Index page where I see the new Team displayed.
      it "navigates to new form to add team to database" do
        visit "/teams"

        expect(page).to have_link(nil, href: "/teams/new")
      end

      it "shows a form and handles the input to create a new team" do
        visit "/teams/new"

        expect(page).to have_button "Create Team"
      end
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

    describe "update team" do
      # As a league manager<br>
      #     When I visit a team show page<br>
      #     Then I see a link to update the team "Update Team"<br>
      #     When I click the link "Update Team"<br>
      #     Then I am taken to '/teams/:id/edit' where I  see a form to edit the team's attributes:<br>
      #     When I fill out the form with updated information<br>
      #     And I click the button to submit the form<br>
      #     Then a `PATCH` request is sent to '/teams/:id',
      #     the team's info is updated,
      #     and I am redirected to the Team's Show page where I see the team's updated info
      it "allows to update the team" do
        visit "/teams/#{@team1.id}"

        expect(page).to have_button "Update Team"
      end

      it "navigates to an edit form" do
        visit "/teams/#{@team1.id}/edit"

        expect(page).to have_button "Update"
      end
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

    describe "team player creation" do
      # As a league manager<br>
      #     When I visit a Team Children Index page<br>
      #     Then I see a link to add a new adoptable player for that team "Create Player"<br>
      #     When I click the link<br>
      #     I am taken to '/teams/:team_id/players/new' where I see a form to add a new adoptable player<br>
      #     When I fill in the form with the player's attributes:<br>
      #     And I click the button "Create Player"<br>
      #     Then a `POST` request is sent to '/teams/:team_id/players',
      #     a new player object/row is created for that team,
      #     and I am redirected to the Team Players Index page where I can see the new player listed
      it "has button for user to create player that will belong to team" do
        visit "/teams/#{@team1.id}/players"

        expect(page).to have_button "Create Player"

        click_link("Create Player")

        expect(page).to have_current_path "/teams/#{@team1.id}/players/new"
      end

      it "has a form to create player and add to team" do
        visit "/teams/#{@team1.id}/players/new"

        fill_in("Name", with: "New Player")
        fill_in("MLB Team", with: "FA")
        fill_in("POS", with: "OF")
        fill_in("xwOBA", with: "0.899")

        expect(page).to have_button "Create Player"
        click_button("Create Player")

        expect(page).to have_content "New Player"
      end
    end

    describe "team player sort functionality" do
      it "has link on team's players page to sort the players alphabetically" do
        # As a league manager<br>
        #     When I visit the Team's players Index Page<br>
        #     Then I see a link to sort players in alphabetical order<br>
        #     When I click on the link<br>
        #     I'm taken back to the Team's players Index Page where I see all of the team's players in alphabetical order
        visit "/teams/#{@team1.id}/players"

        click_link "Sort by Name"

        expect(@p2.name).to appear_before @p1.name
      end
    end
  end
end
