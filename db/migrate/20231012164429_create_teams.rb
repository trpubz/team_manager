class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :abbrv
      t.string :owner
      t.float :win_pct
      t.boolean :joined

      t.timestamps
    end
  end
end
