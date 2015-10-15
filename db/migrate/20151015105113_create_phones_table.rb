class CreatePhonesTable < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :sound
      t.string :sound_type
    end
  end
end
