class CreateShipPositions < ActiveRecord::Migration[5.2]
  def change
    create_table :ship_positions do |t|
      t.integer :X
      t.integer :Y
      t.belongs_to :game_ship, foreign_key: true
      
      t.timestamps
    end
  end
end
