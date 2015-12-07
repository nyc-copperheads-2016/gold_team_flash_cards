class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.string :guess, null: false
      t.boolean :correct, null: false
      ## You can pass constraints even on references...
      ## You should if the object cannot exist without those refs
      t.references :card, null: false
      t.references :round, null: false

      t.timestamps null: false
    end
  end
end
