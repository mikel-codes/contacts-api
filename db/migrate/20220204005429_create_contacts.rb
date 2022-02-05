class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :phone, null: false
      t.string :description

      t.timestamps
    end
    add_index :contacts, :phone, unique: true
  end
end
