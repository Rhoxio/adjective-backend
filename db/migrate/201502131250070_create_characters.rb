class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.string :player_class
      t.string :gender
      t.integer :currency

      t.integer :level
      t.integer :exp
      t.integer :skill
      t.integer :skill_exp

      t.integer :max_hp
      t.integer :current_hp
      
      t.integer :attack_rating
      t.integer :initiative
      t.integer :defense
      
      t.string :avatar            
      t.string :headshot

      t.integer :location, :array => true

      t.integer :weapon_id
      t.integer :shield_id

      t.string :user_id

      t.timestamps
    end
  end
end
