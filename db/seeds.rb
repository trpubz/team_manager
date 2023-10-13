# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Team.destroy_all

@team1 = Team.create!(name: "Julio's Juice Box Boys", abbrv: "PEWB", owner: "TP", win_pct: 0.5595, joined: true)
@team2 = Team.create!(name: "Campus Popo", abbrv: "POPO", owner: "Dave P", win_pct: 0.5238, joined: true)
@team3 = Team.create!(name: "Pablo Sanchez's", abbrv: "DIRT", owner: "Tanner P", win_pct: 0.4940, joined: true)
@p1 = Player.create!(
  name: "Julio Rodriquez",
  mlb_team: "SEA",
  pos: "OF",
  xwOBA: 0.346,
  xFIP: nil,
  injured: false,
  team_id:
    @team1.id
)
@p2 = Player.create!(
  name: "Aaron Judge",
  mlb_team: "NYY",
  pos: "OF",
  xwOBA: 0.468,
  xFIP: nil,
  injured: true,
  team_id:
    @team2.id
)
@p3 = Player.create!(
  name: "Jacob DeGrom",
  mlb_team: "TEX",
  pos: "SP",
  xwOBA: nil,
  xFIP: 2.32,
  injured: true,
  team_id:
    @team3.id
)
@p4 = Player.create!(
  name: "Corbin Carroll",
  mlb_team: "ARI",
  pos: "OF",
  xwOBA: 0.346,
  xFIP: nil,
  injured: false,
  team_id: @team1.id
)
