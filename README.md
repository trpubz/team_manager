# Relational Rails

Exploration of Rails framework with simple database relationships.
Project 1 -- Mod 2 -- Backend -- Turing
![rosters.png](rosters.png)

## User Stories
#### CRUD
 - [x] User Story 1, Team Index
   - For the team table<br>
     As a league manager<br>
     When I visit '/teams'<br>
     Then I see the name of each team record in the system<br>
 - [x] User Story 2, Team Show
   - As a league manager<br>
     When I visit '/teams/:id'<br>
     Then I see the team with that id including the team's attributes<br>
     (data from each column that is on the team table)
 - [x] User Story 3, Player Index 
   - As a league manager<br>
     When I visit '/players'<br>
     Then I see each Player in the system including the Player's attributes<br>
     (data from each column that is on the player table)
 - [x] User Story 4, Player Show 
   - As a league manager<br>
     When I visit '/players/:id'<br>
     Then I see the player with that id including the player's attributes<br>
     (data from each column that is on the player table)
 - [x] User Story 5, Team Player Index
   - As a league manager<br>
     When I visit '/teams/:team_id/players'<br>
     Then I see each Player that is associated with that Team with each Player's attributes<br>
     (data from each column that is on the player table)
#### ActiveRecord
 - [x] User Story 6, Team Index sorted by Most Recently Created 
   - As a league manager<br>
     When I visit the team index,<br>
     I see that records are ordered by most recently created first<br>
     And next to each of the records I see when it was created<br>
 - [x] User Story 7, Team Player Count
   - As a league manager<br>
     When I visit a team's show page<br>
     I see a count of the number of players associated with this team<br>
#### Usability
 - [x] User Story 8, Player Index Link
   - As a league manager<br>
     When I visit any page on the site<br>
     Then I see a link at the top of the page that takes me to the Player Index<br>
 - [x] User Story 9, Team Index Link
   - As a league manager<br>
     When I visit any page on the site<br>
     Then I see a link at the top of the page that takes me to the Team Index<br>
 - [x] User Story 10, Team Player Index Link
   - As a league manager<br>
     When I visit a team show page ('/teams/:id')<br>
     Then I see a link to take me to that team's `player` page ('/teams/:id/players')