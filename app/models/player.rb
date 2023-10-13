class Player < ApplicationRecord
  has_one :team
  # allow nullable foreign key rails

  def injured_str
    if injured
      "Yes"
    else
      "No"
    end
  end

  def self.healthy?
    Player.where(injured: false)
  end

  def self.sorted_by_name
    Player.order(name: :asc)
  end
end
