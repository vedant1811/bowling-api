class CreateBalls < ActiveRecord::Migration[5.2]
  def change
    create_table :balls do |t|
      t.belongs_to :frame, foreign_key: true, null: false
      t.integer :pins, null: false

      t.timestamps
    end
  end
end
