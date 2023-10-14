class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :mlb_team
      t.string :pos
      t.float :xwoba
      t.float :xfip
      t.boolean :injured

      t.timestamps
    end
  end
end
