class CreateSyllablesTable < ActiveRecord::Migration
  def change
    create_table :syllables do |t|
      t.references :phone
      t.integer :stress
    end
  end
end
