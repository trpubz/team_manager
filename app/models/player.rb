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

  def self.filter_above(column, value)
    v = if value.is_a?(String)
      value.empty? ? 0 : value
    else
      value
        end

    Player.where("\"#{column}\" >= #{v}")
  end
end
