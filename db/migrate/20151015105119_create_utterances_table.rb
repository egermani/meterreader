class CreateUtterancesTable < ActiveRecord::Migration
  def change
    create_table :utterances do |t|
      t.references :word
      t.references :syllable
      t.integer :start_dist
      t.integer :end_dist
    end
  end
end
