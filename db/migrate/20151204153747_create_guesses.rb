class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.string :guess, null: false
      t.boolean :correct, null: false
      t.references :card
      t.references :round

      t.timestamps null: false
    end
  end
end
