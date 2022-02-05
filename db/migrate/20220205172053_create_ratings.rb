class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.references :contact, null: false, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
