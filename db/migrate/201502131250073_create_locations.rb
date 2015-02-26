class CreateLocations < ActiveRecord::Migration
	def change
		create_table :locations do |t|
			t.string :name
			t.string :background_path
			t.string :battle_background
			t.string :coordinates

			t.string :js_view
			t.string :js_controller
			t.string :js_battle

			t.integer :enemy_types, :array => true
	  end
	end
end
