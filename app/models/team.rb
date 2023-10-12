class Team < ApplicationRecord
  has_many :players

  def joined_str
    if joined
      "Yes"
    else
      "no"
    end
  end

  def count_players
    players.count
  end
end
