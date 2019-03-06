class CreateSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :subs do |t|
      t.string :title, null: false 
      t.text :description, null: false 
      t.integer :moderator_id, null: false 
    end

    add_index :subs, :moderator_id 
    add_index :subs, :title, unique: true 
  end
end
