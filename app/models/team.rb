class Team < ApplicationRecord
  has_many :players, dependent: :destroy

  def joined_str
    if joined
      "Yes"
    else
      "No"
    end
  end

  def count_players
    players.count
  end
end
