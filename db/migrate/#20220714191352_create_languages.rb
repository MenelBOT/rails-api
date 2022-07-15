class CreateLanguages < ActiveRecord::Migration[7.0]
  def change
    create_table :programming_languages do |t|
      t.integer :id
      t.string :name
      t.integer :released_year
      t.integer :githut_rank
      t.integer :pypl_rank
      t.integer :tiobe_rank
      t.timestamps
    end
  end
end
