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
end
